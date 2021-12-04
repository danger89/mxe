# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := fribidi
$(PKG)_WEBSITE  := https://fribidi.org/
$(PKG)_DESCR    := FriBidi
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 1.0.11
$(PKG)_CHECKSUM := 0e6d631c184e1012fb3ae86e80adabf26e46b4ffee2332e679eb308edd337398
$(PKG)_GH_CONF  := fribidi/fribidi/releases,v,,,,.tar.gz
$(PKG)_DEPS     := cc

define $(PKG)_BUILD
    $(MXE_MESON_WRAPPER) --buildtype=release -Dtests=false -Ddocs=false '$(BUILD_DIR)' '$(SOURCE_DIR)' && \
    ninja -C '$(BUILD_DIR)' -j '$(JOBS)' && \
    ninja -C '$(BUILD_DIR)' -j '$(JOBS)' install

    #cd '$(1)' && ./configure \
    #    $(MXE_CONFIGURE_OPTS) \
    #    --disable-debug \
    #    --disable-deprecated \
    #    $(if $(BUILD_STATIC), \
    #        --enable-static )
    #$(MAKE) -C '$(1)' -j '$(JOBS)' install bin_PROGRAMS= sbin_PROGRAMS= noinst_PROGRAMS= dist_man_MANS=
endef
