# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := gobject-introspection
$(PKG)_WEBSITE  := https://gi.readthedocs.io
$(PKG)_DESCR    := GObject introspection is a middleware layer between C libraries (using GObject) and language bindings.
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.70.0
$(PKG)_CHECKSUM := 902b4906e3102d17aa2fcb6dad1c19971c70f2a82a159ddc4a94df73a3cafc4a
$(PKG)_SUBDIR   := gobject-introspection-$($(PKG)_VERSION)
$(PKG)_FILE     := gobject-introspection-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://download.gnome.org/sources/gobject-introspection/$(call SHORT_PKG_VERSION,$(PKG))/$($(PKG)_FILE)
$(PKG)_DEPS     := cc meson-wrapper
$(PKG)_TARGETS  := $(BUILD) $(MXE_TARGETS)

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://gitlab.gnome.org/GNOME/gobject-introspection/tags' | \
    $(SED) -n "s,.*<a [^>]\+>v\?\([0-9]\+\.[0-9.]\+\)<.*,\1,p" | \
    $(SORT) -Vr | \
    head -1
endef

define $(PKG)_BUILD
    # native build
    $(MXE_MESON_NATIVE_WRAPPER) -Dcairo=disabled -Ddoctool=disabled '$(BUILD_DIR)' '$(SOURCE_DIR)' && \
    ninja -C '$(BUILD_DIR)' -j '$(JOBS)' && \
    ninja -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef
