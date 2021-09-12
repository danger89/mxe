#!/usr/bin/env bash
# Original source from: https://github.com/devkitPro/pacman-packages/blob/master/dkp-meson-scripts/meson-toolchain.sh
# Adapted by Melroy van den Berg
#
# Usage:
#  Executue this script with either "windows32" or "windows64" parameter for the platform


#SCRIPTDIR="${BASH_SOURCE%/*}"

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
	echo "No platform specified." 1>&2
	exit 1
fi

case "$1" in
"windows32")
        PLAT_SYSTEM="windows"
        PLAT_CPU_FAMILY="x86"
        PLAT_CPU="i686"
        PLAT_ENDIAN="little"
        ;;
"windows64")
        PLAT_SYSTEM="windows"
        PLAT_CPU_FAMILY="x86_64"
        PLAT_CPU="amd64"
        PLAT_ENDIAN="little"
        ;;
*)
	echo "Unsupported platform." 1>&2
	exit 1
	;;
esac

#echo "[binaries]"
#echo "c = '` which ${TOOL_PREFIX}gcc `'"
#echo "cpp = '` which ${TOOL_PREFIX}g++ `'"
#echo "ar = '` which ${TOOL_PREFIX}gcc-ar `'"
#echo "strip = '` which ${TOOL_PREFIX}strip `'"
#echo "pkgconfig = '` which ${TOOL_PREFIX}pkg-config `'"
#echo ""
#echo "[built-in options]"
#echo "c_args = [` make_flag_list $CPPFLAGS $CFLAGS `]"
#echo "c_link_args = [` make_flag_list $LDFLAGS $LIBS `]"
#echo "cpp_args = [` make_flag_list $CPPFLAGS $CXXFLAGS `]"
#echo "cpp_link_args = [` make_flag_list $LDFLAGS $LIBS `]"
#echo ""
echo "[properties]"
echo "sys_root = '/opt/mxe/usr/x86_64-w64-mingw32.static.posix'"
echo "pkg_config_libdir = '/some/path/lib/pkgconfig'"
echo ""
echo "[host_machine]"
echo "system = '${PLAT_SYSTEM}'"
echo "cpu_family = '${PLAT_CPU_FAMILY}'"
echo "cpu = '${PLAT_CPU}'"
echo "endian = '${PLAT_ENDIAN}'"
echo ""
