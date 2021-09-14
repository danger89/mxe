# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := atk
$(PKG)_WEBSITE  := https://gtk.org/
$(PKG)_DESCR    := ATK
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.34.1
$(PKG)_CHECKSUM := d4f0e3b3d21265fcf2bc371e117da51c42ede1a71f6db1c834e6976bb20997cb
$(PKG)_SUBDIR   := atk-$($(PKG)_VERSION)
$(PKG)_FILE     := atk-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://download.gnome.org/sources/atk/$(call SHORT_PKG_VERSION,$(PKG))/$($(PKG)_FILE)
# Also need meson & ninja now
$(PKG)_DEPS     := cc gettext glib

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://gitlab.gnome.org/GNOME/atk/tags' | \
    $(SED) -n "s,.*<a [^>]\+>ATK_\([0-9]\+_[0-9_]\+\)<.*,\1,p" | \
    $(SED) "s,_,.,g;" | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && ./tools/meson-toolchain.sh $(PREFIX) $(TARGET) > ./cross-compile.ini && \
    meson $(MXE_MESON_OPTIONS) --cross-file=./cross-compile.ini _build .
    ninja -C _build
    ninja -C _build install

    # OLD:
    #cd '$(1)' && ./configure \
    #    $(MXE_CONFIGURE_OPTS)
    #$(MAKE) -C '$(1)' -j '$(JOBS)' $(MXE_DISABLE_CRUFT) SUBDIRS='atk po' SHELL=bash
    #$(MAKE) -C '$(1)' -j 1 install $(MXE_DISABLE_CRUFT) SUBDIRS='atk po'
endef
