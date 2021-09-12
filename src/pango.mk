# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := pango
$(PKG)_WEBSITE  := https://www.pango.org/
$(PKG)_DESCR    := Pango
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.41.1
$(PKG)_CHECKSUM := 1353a4cf5227299294955d0c6232326b346b087ebac6496241d54ca5d2e2abc3
$(PKG)_SUBDIR   := pango-$($(PKG)_VERSION)
$(PKG)_FILE     := pango-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://download.gnome.org/sources/pango/$(call SHORT_PKG_VERSION,$(PKG))/$($(PKG)_FILE)
$(PKG)_DEPS     := cc cairo fontconfig freetype glib harfbuzz

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://gitlab.gnome.org/GNOME/pango/tags' | \
    $(SED) -n "s,.*<a [^>]\+>v\?\([0-9]\+\.[0-9.]\+\)<.*,\1,p" | \
    head -1
endef

define $(PKG)_BUILD
    rm '$(1)'/docs/Makefile.am
    cd '$(1)' && NOCONFIGURE=1 ./autogen.sh
    cd '$(1)' && ./configure \
        $(MXE_CONFIGURE_OPTS) \
        --enable-explicit-deps \
        --with-included-modules \
        --without-dynamic-modules \
        CXX='$(TARGET)-g++'
    $(MAKE) -C '$(1)' -j '$(JOBS)' install bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
endef
