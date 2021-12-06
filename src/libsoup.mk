# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := libsoup
$(PKG)_WEBSITE  := https://github.com/GNOME/libsoup
$(PKG)_DESCR    := HTTP client/server library for GNOME
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.74.2
$(PKG)_APIVER   := 2.4
$(PKG)_CHECKSUM := c9dc5d6499377598b5189acb787dd37c14484f8a50e399d94451c13b4af88b0f
$(PKG)_GH_CONF  := GNOME/libsoup/tags,,,pre\|SOUP\|base
$(PKG)_DEPS     := cc meson-wrapper glib libpsl libxml2 sqlite

define $(PKG)_BUILD
    $(MXE_MESON_WRAPPER) --buildtype=release \
        -Dintrospection=disabled \
        -Dtests=false \
        -Dinstalled_tests=false \
        -Dvapi=disabled \
        -Dgssapi=disabled \
        -Dsysprof=disabled \
        -Dtls_check=false \
        '$(BUILD_DIR)' '$(SOURCE_DIR)' && \
    ninja -C '$(BUILD_DIR)' -j '$(JOBS)' && \
    ninja -C '$(BUILD_DIR)' -j '$(JOBS)' install

    # -fcommon for gcc10, remove at next update
    # https://gcc.gnu.org/gcc-10/porting_to.html
#    cd '$(SOURCE_DIR)' && \
#        NOCONFIGURE=1 \
#        ACLOCAL_FLAGS=-I'$(PREFIX)/$(TARGET)/share/aclocal' \
#        ./autogen.sh
#    cd '$(BUILD_DIR)' && '$(SOURCE_DIR)'/configure \
#        $(MXE_CONFIGURE_OPTS) \
#        --disable-vala \
#        --without-apache-httpd \
#        --without-gssapi \
#        CFLAGS='-fcommon' \
#        $(shell [ `uname -s` == Darwin ] && echo "INTLTOOL_PERL=/usr/bin/perl")
#    $(MAKE) -C '$(BUILD_DIR)' -j $(JOBS)
#    $(MAKE) -C '$(BUILD_DIR)' -j 1 install

    $(TARGET)-gcc \
        -W -Wall -Werror -ansi \
        '$(TEST_FILE)' -o '$(PREFIX)/$(TARGET)/bin/test-$(PKG).exe' \
        `$(TARGET)-pkg-config $(PKG)-$($(PKG)_APIVER) --cflags --libs`
endef
