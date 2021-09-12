# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := cairomm
$(PKG)_WEBSITE  := https://cairographics.org/cairomm/
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.13.1
$(PKG)_CHECKSUM := 97a78bd7de6baf8af3da1f9b39f1317f8da9f1145b7694e928fbd5521da08ef6
$(PKG)_SUBDIR   := cairomm-$($(PKG)_VERSION)
$(PKG)_FILE     := cairomm-$($(PKG)_VERSION).tar.gz
$(PKG)_URL      := https://cairographics.org/releases/$($(PKG)_FILE)
$(PKG)_DEPS     := cc cairo libsigc++

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://cairographics.org/releases/?C=M;O=D' | \
    $(SED) -n 's,.*"cairomm-\([0-9][^"]*\)\.tar.*,\1,p' | \
    $(SORT) -V | \
    tail -1
endef

define $(PKG)_BUILD
    cd '$(1)' && ./configure \
        $(MXE_CONFIGURE_OPTS) \
        MAKE=$(MAKE)
    $(MAKE) -C '$(1)' -j '$(JOBS)' install $(MXE_DISABLE_CRUFT)
endef

