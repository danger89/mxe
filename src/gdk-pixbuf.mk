# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := gdk-pixbuf
$(PKG)_WEBSITE  := https://gtk.org/
$(PKG)_DESCR    := GDK-pixbuf
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 2.42.6
$(PKG)_CHECKSUM := c4a6b75b7ed8f58ca48da830b9fa00ed96d668d3ab4b1f723dcf902f78bde77f
$(PKG)_SUBDIR   := gdk-pixbuf-$($(PKG)_VERSION)
$(PKG)_FILE     := gdk-pixbuf-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://download.gnome.org/sources/gdk-pixbuf/$(call SHORT_PKG_VERSION,$(PKG))/$($(PKG)_FILE)
$(PKG)_DEPS     := cc meson-wrapper glib jasper jpeg libiconv libpng tiff

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://gitlab.gnome.org/GNOME/gdk-pixbuf/tags' | \
    $(SED) -n "s,.*<a [^>]\+>v\?\([0-9]\+\.[0-9.]\+\)<.*,\1,p" | \
    grep -v '^2\.9' | \
    head -1
endef

define $(PKG)_BUILD
    $(MXE_MESON_WRAPPER) --buildtype=release -Dinstalled_tests=false -Dintrospection=disabled -Dman=false '$(BUILD_DIR)' '$(SOURCE_DIR)' && \
    ninja -C '$(BUILD_DIR)' -j '$(JOBS)' && \
    ninja -C '$(BUILD_DIR)' -j '$(JOBS)' install
    # -fcommon for gcc10, remove at next update
    # https://gcc.gnu.org/gcc-10/porting_to.html
    #cd '$(1)' && autoreconf -fi -I'$(PREFIX)/$(TARGET)/share/aclocal'
    #cd '$(1)' && ./configure \
    #    $(MXE_CONFIGURE_OPTS) \
    #    $(if $(BUILD_STATIC), \
    #       --disable-modules,) \
    #    --with-included-loaders \
    #    --without-gdiplus \
    #    CFLAGS='-fcommon' \
    #    LIBS="`'$(TARGET)-pkg-config' --libs libtiff-4`"
    #$(MAKE) -C '$(1)' -j '$(JOBS)' install
endef
