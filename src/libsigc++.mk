# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libsigc++
$(PKG)_WEBSITE  := https://libsigc.sourceforge.io/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.9.3
$(PKG)_CHECKSUM := 0bf9b301ad6198c550986c51150a646df198e8d1d235270c16486b0dda30097f
$(PKG)_GH_CONF  := libsigcplusplus/libsigcplusplus/releases,,,99,,.tar.xz
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_URL_2    := https://download.gnome.org/sources/libsigc++/$(call SHORT_PKG_VERSION,$(PKG))/libsigc++-$($(PKG)_VERSION).tar.xz
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    cd '$(BUILD_DIR)' && '$(SOURCE_DIR)/configure' \
        $(MXE_CONFIGURE_OPTS) \
        CXX='$(TARGET)-g++' \
        PKG_CONFIG='$(PREFIX)/bin/$(TARGET)-pkg-config' \
        MAKE=$(MAKE)
    $(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_CRUFT)
    $(MAKE) -C '$(BUILD_DIR)' -j 1 install $(MXE_DISABLE_CRUFT)
endef
