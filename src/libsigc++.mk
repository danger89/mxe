# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libsigc++
$(PKG)_WEBSITE  := https://libsigc.sourceforge.io/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3.0.7
$(PKG)_CHECKSUM := bfbe91c0d094ea6bbc6cbd3909b7d98c6561eea8b6d9c0c25add906a6e83d733
$(PKG)_GH_CONF  := libsigcplusplus/libsigcplusplus/releases,,,99,,.tar.xz
$(PKG)_SUBDIR   := $(PKG)-$($(PKG)_VERSION)
$(PKG)_URL_2    := https://download.gnome.org/sources/libsigc++/$(call SHORT_PKG_VERSION,$(PKG))/libsigc++-$($(PKG)_VERSION).tar.xz
$(PKG)_DEPS     := cc meson-wrapper

define $(PKG)_BUILD
    $(MXE_MESON_WRAPPER) --buildtype=release \
        -Dbuild-documentation=false \
        -Dbuild-examples=false \
        '$(BUILD_DIR)' '$(SOURCE_DIR)' && \
    ninja -C '$(BUILD_DIR)' -j '$(JOBS)' && \
    ninja -C '$(BUILD_DIR)' -j '$(JOBS)' install

    #cd '$(BUILD_DIR)' && '$(SOURCE_DIR)/configure' \
    #    $(MXE_CONFIGURE_OPTS) \
    #    CXX='$(TARGET)-g++' \
    #    PKG_CONFIG='$(PREFIX)/bin/$(TARGET)-pkg-config' \
    #    MAKE=$(MAKE)
    #$(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_CRUFT)
    #$(MAKE) -C '$(BUILD_DIR)' -j 1 install $(MXE_DISABLE_CRUFT)
endef
