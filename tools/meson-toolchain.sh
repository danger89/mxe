#!/usr/bin/env bash
# Original source from: https://github.com/devkitPro/pacman-packages/blob/master/dkp-meson-scripts/meson-toolchain.sh
# Adapted by Melroy van den Berg
#
# Usage:
# ./tools/meson-toolchain.sh $(PREFIX) $(TARGET)
#
# Fist parameter is the prefix path,
# Seconf parameter is the platform for cross-compiling.

make_flag_list()
{
	while (( "$#" )); do
		echo -n "'$1'";
		if [ $# -gt 1 ]; then
			echo -n ",";
		fi
		shift
	done
}

if [ -z "$1" ]; then
	echo "No prefix specified." 1>&2
	exit 1
fi
if [ -z "$2" ]; then
        echo "No target specified." 1>&2
        exit 1
fi


if [[ "$2" =~ ^i686* ]]; then
        PLAT_SYSTEM="windows"
        PLAT_CPU_FAMILY="x86"
        PLAT_CPU="i686"
        PLAT_ENDIAN="little"
elif [[ "$2" =~ ^x86_64* ]]; then
        PLAT_SYSTEM="windows"
        PLAT_CPU_FAMILY="x86_64"
        PLAT_CPU="amd64"
        PLAT_ENDIAN="little"
else
	echo "Unsupported platform." 1>&2
        exit 1
fi

toolchain_prefix="$1/bin/$2-"
echo "[binaries]"
echo "c = '${toolchain_prefix}gcc'"
echo "cpp = '${toolchain_prefix}g++'"
echo "ar = '${toolchain_prefix}ar'"
echo "strip = '${toolchain_prefix}strip'"
echo "windres = '${toolchain_prefix}windres'"
echo "pkgconfig = '${toolchain_prefix}pkg-config'"
echo ""
#echo "[built-in options]"
#echo "c_args = [` make_flag_list $CPPFLAGS $CFLAGS `]"
#echo "c_link_args = [` make_flag_list $LDFLAGS $LIBS `]"
#echo "cpp_args = [` make_flag_list $CPPFLAGS $CXXFLAGS `]"
#echo "cpp_link_args = [` make_flag_list $LDFLAGS $LIBS `]"
#echo ""
echo "[properties]"
echo "sys_root = '$1/$2'"
echo "pkg_config_libdir = '$1/$2/lib/pkgconfig'"
echo ""
echo "[host_machine]"
echo "system = '${PLAT_SYSTEM}'"
echo "cpu_family = '${PLAT_CPU_FAMILY}'"
echo "cpu = '${PLAT_CPU}'"
echo "endian = '${PLAT_ENDIAN}'"
echo ""
