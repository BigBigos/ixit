# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit git-r3 cmake-utils

DESCRIPTION="A general purpose library for the OpenWRT project."
HOMEPAGE="http://wiki.openwrt.org/"
EGIT_REPO_URI="git://nbd.name/luci2/${PN}.git"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="
	dev-libs/libnl
	sys-apps/ubus
	sys-apps/uci
"

src_prepare() {
	echo 'INCLUDE_DIRECTORIES(/usr/include/libnl3)' >> CMakeLists.txt
	sed -i 's/-Werror //' CMakeLists.txt
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_LUA=OFF
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	install -d "${D}/etc/config"
	touch "${D}/etc/config/network"
	touch "${D}/etc/config/wireless"
}
