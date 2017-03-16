#!/usr/bin/env python
"""
USAGE: template.py [OPTIONS] [INPUT]
    INPUT    Input file (or directory in dir mode). STDIN if omitted or '-'
OPTIONS:
    --help                 Show this help
    -o, --output OUTPUT    Write result to OUTPUT
    -v, --verbose          Increases verbosity
    -c, --config FILE      Load colors from FILE
    -d, --dir              Directory mode: renders all files in INPUT
"""
import sys
import os
import json
import math
import colorsys
from os import path
from itertools import count, islice, chain
from getopt import gnu_getopt
from jinja2 import Template


BASE16_COLORS_LABELS = ["color%d" % n for n in range(0, 16)]


def _genereate_ext_256():
    """
    Generates UNIX 240 colors (for 256 standard)
    """
    gstep = 10
    ginit = 8
    csteps = [0x00, 0x5f, 0x87, 0xaf, 0xdf, 0xff]
    c216 = [Color(r, g, b)
            for r in csteps
            for g in csteps
            for b in csteps]
    greys = [Color(a, a, a) for a in islice(count(ginit, gstep), 24)]
    return list(zip(count(16), c216 + greys))


class Color:
    """
    Color representation
    """
    colors256 = {}

    @staticmethod
    def from_hex(s):
        """
        Construct a Color instance with a #RRGGBB string
        """
        s = s[1:]
        r = int(s[0:2], 16)
        g = int(s[2:4], 16)
        b = int(s[4:6], 16)
        return Color(r, g, b)

    @staticmethod
    def generate_base256_colors(elems):
        """
        Generate 256 colors from parsed colors
        """
        base16 = ((int(k[5:]), elems.get(k, None))
                  for k in BASE16_COLORS_LABELS)
        Color.colors256 = list(chain(base16, _genereate_ext_256()))

    def __init__(self, r, g, b):
        self.r = r
        self.g = g
        self.b = b

    def rgb(self):
        """
        return (R, G, B) tuple
        """
        return self.r, self.g, self.b

    def hex(self):
        """
        return #RRGGBB
        """
        r, g, b = self.rgb()
        return "#%.2x%.2x%.2x" % (int(r), int(g), int(b))

    def hsv(self):
        """
        return (H, S, V) tuple
        """
        return colorsys.rgb_to_hsv(*self.rgb())

    def brighten(self, percent):
        """
        return a new color with modified brightness
        """
        (h, s, v) = self.hsv()
        p = percent * 256 / 100
        v = min(255, v + p)
        return Color(*colorsys.hsv_to_rgb(h, s, v))

    def distance(self, rhs):
        """
        return vectorial distance between self and rhs
        """
        (px, py, pz) = self.rgb()
        (qx, qy, qz) = rhs.rgb()
        return math.sqrt((px - qx) ** 2 +
                         (py - qy) ** 2 +
                         (pz - qz) ** 2)

    def nearest(self, colors):
        """
        return key of nearest color from a dictionary
        """
        dists = {k: self.distance(v) for k, v in colors.items()}
        return min(dists.items(), key=lambda t: t[1])[0]

    def base8(self):
        return self.nearest(dict(Color.colors256[0:7]))

    def base16(self):
        return self.nearest(dict(Color.colors256[0:15]))

    def base256(self):
        return self.nearest(dict(Color.colors256))

    def __str__(self):
        return self.hex()

    def __repr__(self):
        return self.hex()


class Opacity:
    """
    Opacity representation
    """
    def __init__(self, percent):
        self.percent = min(percent, 100)

    def trasparent(self):
        """
        return a Opacity object representing transparency
        """
        return Opacity(100 - self.percent)

    def float(self):
        """
        float representation
        """
        return self.percent / 100

    def base256(self):
        """
        base 256 representation
        """
        return int(self.float() * 255)

    def hex(self):
        """
        hexadecimal representation
        """
        return "%.2x" % self.base256()

    def __str__(self):
        return str(self.percent)

    def __repr__(self):
        return str(self.percent)


class Options:
    """
    Class encapsulating options logic
    """
    def __init__(self, argv):
        self.config = "./colors.json"
        self.input = None
        self.output = None
        self.help = False
        self.verbosity = 0
        self.dirmode = False

        long_opts = ["config=", "output=", "verbose", "dir", "help"]
        opts, args = gnu_getopt(argv, "c:o:vd", long_opts)

        for opt, optarg in opts:
            if opt == "-o":
                self.output = optarg
            elif opt == "-v":
                self.verbosity += 1
            elif opt == "--help":
                self.help = True
            elif opt in ("-c", "--config"):
                self.config = optarg
            elif opt in ("-d", "--dir"):
                self.dirmode = True

        if len(args):
            self.input = args[-1]


def load_configs(conf_file):
    """
    Loads JSON configurations from conf_file
    """
    with open(conf_file) as fh:
        return json.loads(fh.read())


def _parse_value(val):
    if isinstance(val, str) and val[0] == "#":
        return Color.from_hex(val)
    return val


def template_elements(conf):
    """
    Generates elements for templates
    """
    return {k: _parse_value(v) for k, v in conf.items()}


def render(elems, strm):
    """
    Renders template
    """
    helpers = {'Opacity': Opacity}
    return Template(strm.read()).render(**elems, **helpers)


def open_streams(opts):
    """
    Opens file stream based on option settings
    """
    if opts.verbosity:
        infn = "STDIN" if opts.input in (None, "-") else opts.input
        outfn = "STDOUT" if opts.output is None else opts.output
        log("in:  {}\nout: {}", infn, outfn)
    infh = sys.stdin if opts.input in (None, "-") else open(opts.input, "r")
    outfh = sys.stdout if opts.output is None else open(opts.output, "w")
    return infh, outfh


def single_render(opts, elems):
    """
    Renders single file
    """
    infh, outfh = open_streams(opts)
    tmpl = render(elems, infh)
    outfh.write(tmpl)
    infh.close()
    outfh.close()


def find_files(root):
    """
    List files (and links) recursively under root
    """
    for p, dirs, files in os.walk(root):
        fp = (path.join(p, f) for f in files)
        yield from filter(path.isfile, fp)


def directory_render(opts, elems):
    """
    Renders entire directory
    """
    for fname in find_files(opts.input):
        if opts.verbosity:
            log("rendering: {}", fname)
        fh = open(fname, "r+")
        tmpl = render(elems, fh)
        fh.seek(0)
        fh.write(tmpl)
        fh.truncate()
        fh.close()


def log(fmt, *args):
    print(fmt.format(*args), file=sys.stderr)


def show_help(iserror=True):
    fo = sys.stderr if iserror else sys.stdout
    code = 1 if iserror else 0
    print(__doc__.strip(), file=fo)
    sys.exit(code)


def main():
    try:
        opts = Options(sys.argv[1:])
    except:
        show_help()
    if opts.help:
        show_help(False)
    elems = template_elements(load_configs(opts.config))
    Color.generate_base256_colors(elems)
    if opts.dirmode:
        directory_render(opts, elems)
    else:
        single_render(opts, elems)


if __name__ == "__main__":
    main()
