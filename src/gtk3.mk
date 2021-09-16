# This file is part of MXE. See LICENSE.md for licensing information.

PKG             := gtk3
$(PKG)_WEBSITE  := https://gtk.org/
$(PKG)_DESCR    := GTK+
$(PKG)_IGNORE   :=
$(PKG)_VERSION  := 3.24.30
$(PKG)_CHECKSUM := ba75bfff320ad1f4cfbee92ba813ec336322cc3c660d406aad014b07087a3ba9
$(PKG)_SUBDIR   := gtk+-$($(PKG)_VERSION)
$(PKG)_FILE     := gtk+-$($(PKG)_VERSION).tar.xz
$(PKG)_URL      := https://download.gnome.org/sources/gtk+/$(call SHORT_PKG_VERSION,$(PKG))/$($(PKG)_FILE)
# also needs gobject-introspection (https://gitlab.gnome.org/GNOME/gobject-introspection) and wayland ?
$(PKG)_DEPS     := atk cairo gdk-pixbuf gettext glib jasper jpeg libepoxy libpng pango tiff

define $(PKG)_UPDATE
    $(WGET) -q -O- 'https://gitlab.gnome.org/GNOME/gtk+/tags' | \
    $(SED) -n "s,.*<a [^>]\+>v\?\([0-9]\+\.[0-9.]\+\)<.*,\1,p" | \
    grep '^3\.' | \
    grep -v '^3\.9[0-9]' | \
    head -1
endef

define $(PKG)_BUILD
    cd '$(SOURCE_DIR)' && $(PWD)/tools/meson-toolchain.sh $(PREFIX) $(TARGET) > ./cross-compile.ini && \
    # Meson configure, with additional options for GTK
    meson $(MXE_MESON_OPTIONS) -Dtests=false -Dexamples=false -Dbuiltin_immodules=yes --cross-file=./cross-compile.ini _build . && \
    ninja -C _build && \
    ninja -C _build install

    #cd '$(BUILD_DIR)' && '$(SOURCE_DIR)/configure' \
    #    $(MXE_CONFIGURE_OPTS) \
    #    --disable-glibtest \
    #    --disable-cups \
    #    --disable-test-print-backend \
    #    --disable-gtk-doc \
    #    --disable-man \
    #    --with-included-immodules \
    #    --enable-win32-backend
    #$(MAKE) -C '$(BUILD_DIR)' -j '$(JOBS)' $(MXE_DISABLE_CRUFT) EXTRA_DIST=
    #$(MAKE) -C '$(BUILD_DIR)' -j 1 install $(MXE_DISABLE_CRUFT) EXTRA_DIST=

    # cleanup to avoid gtk2/3 conflicts (EXTRA_DIST doesn't exclude it)
    # and *.def files aren't really relevant for MXE
    # TODO: Still relevant to remove?
    rm -f '$(PREFIX)/$(TARGET)/lib/gailutil.def'

    # Just compile our testfile
    '$(TARGET)-gcc' \
        -W -Wall -Werror -ansi \
        '$(TEST_FILE)' -o '$(PREFIX)/$(TARGET)/bin/test-gtk3.exe' \
        `'$(TARGET)-pkg-config' gtk+-3.0 --cflags --libs`
endef
