# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := atkmm
$(PKG)_WEBSITE  := https://www.gtkmm.org/
$(PKG)_DESCR    := ATKmm
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.28.0
$(PKG)_CHECKSUM := 4c4cfc917fd42d3879ce997b463428d6982affa0fb660cafcc0bc2d9afcedd3a
$(PKG)_SUBDIR   := atkmm-$($(PKG)_VERSION)
$(PKG)_FILE     := atkmm-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://download.gnome.org/sources/atkmm/$(call SHORT_PKG_VERSION,$(PKG))/$($(PKG)_FILE)
$(PKG)_DEPS     := cc meson-wrapper atk glibmm

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://gitlab.gnome.org/GNOME/atkmm/tags' | \
    $(SED) -n "s,.*<a [^>]\+>v\?\([0-9]\+\.[0-9.]\+\)<.*,\1,p" | \
    head -1
endef

define $(PKG)_BUILD
    $(MXE_MESON_WRAPPER) --buildtype=release '$(BUILD_DIR)' '$(SOURCE_DIR)' && \
    ninja -C '$(BUILD_DIR)' -j '$(JOBS)' && \
    ninja -C '$(BUILD_DIR)' -j '$(JOBS)' install
endef
