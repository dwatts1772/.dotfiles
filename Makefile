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
PKGS =  nvim zsh oh-my-zsh
else
APT_PKGS = ack firefox git npm tmux zsh terminator
PKGS = albert bin termite oh-my-zsh $(APT_PKGS)
endif
TMPL_INCLUDE = nvim termite tmux oh-my-zsh zsh
DIST_PKGS = $(patsubst %,$(DIST_DIR)/%/,$(PKGS))

STOW_FLAGS = --no-folding -v -d $(DIST_DIR) -t $(HOME)
CURL_FLAGS = --create-dirs
RSVG_FLAGS = -f $(FORMAT)

.PHONY: all
all: $(DIST_PKGS)

.PHONY: install
install:
	@chmod +x ./install/
	@sh -e ./install.sh
	@echo "\n\nStowing from dist folder..."
	@stow -R $(STOW_FLAGS) $(PKGS)

.PHONY: link
link:
	@echo "\n\nStowing from dist folder..."
	@stow -R $(STOW_FLAGS) $(PKGS)

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
	cp -R $(REQ) $(DIST_DIR)

$(DIST_DIR)/%/: %/
	@mkdir -p $(DIST_DIR)
	cp -R $< $(DIST_DIR)

.PHONY: install-apt-packages
install-apt-packages:
	sudo apt install $(APT_PKGS) -y

