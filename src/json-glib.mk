# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := json-glib
$(PKG)_WEBSITE  := https://wiki.gnome.org/action/show/Projects/JsonGlib
$(PKG)_DESCR    := JSON-Glib
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.6.6
$(PKG)_CHECKSUM := 96ec98be7a91f6dde33636720e3da2ff6ecbb90e76ccaa49497f31a6855a490e
$(PKG)_SUBDIR   := json-glib-$($(PKG)_VERSION)
$(PKG)_FILE     := json-glib-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://download.gnome.org/sources/json-glib/$(call SHORT_PKG_VERSION,$(PKG))/$($(PKG)_FILE)
$(PKG)_DEPS     := cc meson-wrapper glib

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://gitlab.gnome.org/GNOME/json-glib/tags' | \
    $(SED) -n "s,.*<a [^>]\+>v\?\([0-9]\+\.[0-9.]\+\)<.*,\1,p" | \
    head -1
endef

define $(PKG)_BUILD
    $(MXE_MESON_WRAPPER) --buildtype=release \
        -Dintrospection=disabled \
        -Dtests=false \
        -Dgtk_doc=disabled \
        '$(BUILD_DIR)' '$(SOURCE_DIR)' && \
    ninja -C '$(BUILD_DIR)' -j '$(JOBS)' && \
    ninja -C '$(BUILD_DIR)' -j '$(JOBS)' install

#    cd '$(1)' && ./configure \
#        $(MXE_CONFIGURE_OPTS)
#    $(MAKE) -C '$(1)/json-glib' -j '$(JOBS)' install bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS=
endef
