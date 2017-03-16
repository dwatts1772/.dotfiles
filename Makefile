#        __      __  _____ __
#   ____/ /___  / /_/ __(_) /__  _____
#  / __  / __ \/ __/ /_/ / / _ \/ ___/
# / /_/ / /_/ / /_/ __/ / /  __(__  )
# \__,_/\____/\__/_/ /_/_/\___/____/
#

min = $(shell (($1 <= $2)) && echo $(1) || echo $(2))
template = $(shell echo '{{$(1)}}' | $(PYTHON) template.py $(TMPL_FLAGS))

ifeq "$(word 2,$(subst ., ,$(shell python --version 2>&1)))" "2"
PYTHON = python3
else
PYTHON = python
endif
RSVG = rsvg-convert

THEME = colors
DIST_DIR = dist
PREFIX = /usr/local
TMP = /tmp
XDG_CONFIG_HOME ?= $(HOME)/.config
XDG_DATA_HOME ?= $(HOME)/.local/share

ifeq "$(shell uname)" "Darwin"
PKGS = ack bin ctags firefox npm nvim tmux zsh
else
PKGS = ack albert bin compton ctags dunst firefox git gtk2 gtk3 jgmenu npm \
	   nvim openbox termite tint2 tmux xpad zsh
endif
TMPL_INCLUDE = compton dunst gtk2 gtk3 jgmenu nvim openbox termite tint2 tmux \
			   xpad zsh
DIST_PKGS = $(patsubst %,$(DIST_DIR)/%/,$(PKGS))

WIDTH = 1366
HEIGHT = 768
DIM = $(call min,$(WIDTH),$(HEIGHT))
FORMAT = png
WALLPAPER = triangle

APPS_ICO_URL = http://i.imgur.com/koYSVm1.png
ONOFF_ICO_URL = http://i.imgur.com/1v7adpq.png
DDG_ICO_URL = http://i.imgur.com/uD5fYLL.png
LOCKER_URL = http://i.imgur.com/T6qtg4R.png

STOW_FLAGS = --no-folding -v -d $(DIST_DIR) -t $(HOME)
TMPL_FLAGS = -c $(THEME).json
CURL_FLAGS = --create-dirs
RSVG_FLAGS = -f $(FORMAT)


.PHONY: all
all: $(DIST_PKGS) wallpaper

.PHONY: install
install:
	stow -R $(STOW_FLAGS) $(PKGS)

.PHONY: uninstall
uninstall:
	stow -D $(STOW_FLAGS) $(PKGS)

.PHONY: clean
clean:
	rm -r $(DIST_DIR)


.PHONY: $(patsubst %,$(DIST_DIR)/%/,$(TMPL_INCLUDE))
$(patsubst %,$(DIST_DIR)/%/,$(TMPL_INCLUDE)):
	@mkdir -p $(DIST_DIR)
	$(eval REQ = $(lastword $(subst /, ,$@)))
	cp -r -t $(DIST_DIR) $(REQ)
	$(PYTHON) template.py -v $(TMPL_FLAGS) -d $@

$(DIST_DIR)/%/: %/
	@mkdir -p $(DIST_DIR)
	cp -r -t $(DIST_DIR) $<


.PHONY: resources
resources:
	curl $(APPS_ICO_URL) $(CURL_FLAGS) -o $(XDG_DATA_HOME)/icons/apps.png
	curl $(ONOFF_ICO_URL) $(CURL_FLAGS) -o $(XDG_DATA_HOME)/icons/onoff.png
	curl $(DDG_ICO_URL) $(CURL_FLAGS) -o $(XDG_DATA_HOME)/icons/ddg.png


#.PHONY: wallpaper
#wallpaper:
#	$(eval TRG = $(DIST_DIR)/$@)
#	@rm -r $(TRG)
#	@mkdir -p $(TRG)
#	cp -r -t $(DIST_DIR) $@
#	$(PYTHON) template.py -v $(TMPL_FLAGS) -d $(TRG)
#	$(RSVG) $(RSVG_FLAGS) -w $(DIM) -h $(DIM) \
#		-o $(TRG)/$(WALLPAPER).png $(TRG)/$(WALLPAPER).svg
#	convert $(TRG)/$(WALLPAPER).png \
#		-gravity center \
#		-background '$(call template,background)' \
#		-extent $(WIDTH)x$(HEIGHT) \
#		$(TRG)/wallpaper.png
#	install -Dm644 $(TRG)/wallpaper.png $(XDG_DATA_HOME)/pixmaps/wallpaper.png


.PHONY: lockscreen
lockscreen:
	mkdir -p $(TMP)/$@
	install -Dm644 $@/lock@.service /etc/systemd/system/lock@.service
	install -Dm755 $@/wmlock $(PREFIX)/bin/wmlock
	curl $(CURL_FLAGS) $(LOCKER_URL) -o $(TMP)/locker.png
	install -Dm755 $(TMP)/locker.png $(PREFIX)/share/pixmaps/wmlock/locker.png

.PHONY: oblogout
oblogout: lockscreen
	install -Dm644 $@/oblogout.conf /etc/oblogout.conf

