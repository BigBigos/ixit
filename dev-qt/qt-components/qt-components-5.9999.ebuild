# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_REPO_URI="git://gitorious.org/${PN}/${PN}.git
	https://git.gitorious.org/${PN}/${PN}.git"

inherit qt5 git-2

DESCRIPTION="QtQuick/QML components and models"
HOMEPAGE="http://qt.gitorious.org/qt-components/qt-components"
LICENSE="BSD"
SLOT="5"
KEYWORDS=""

IUSE="extras meego mobility symbian test"

DEPEND="
	>=dev-qt/qtcore-5.0.2:5
	>=dev-qt/qtdeclarative-5.0.2:5
	meego? (
		>=dev-qt/qtdbus-5.0.2:5
		>=dev-qt/qtopengl-5.0.2:5
		x11-libs/libXdamage
		x11-libs/libXrandr
		mobility? ( >=dev-qt/qt-mobility-1.2[systeminfo] )
	)
	symbian? (
		>=dev-qt/qtsvg-5.0.2:5
		mobility? ( >=dev-qt/qt-mobility-1.2[feedback,systeminfo] )
	)
"
RDEPEND="${DEPEND}"

src_configure() {
	local myconf=(
		./configure
		-prefix "${EPREFIX}/usr"
		-nomake demos
		-nomake examples
		$(use extras && echo -make || echo -nomake) extras
		$(use test && echo -make || echo -nomake) tests
		$(use meego && echo -meego)
		$(use symbian && echo -symbian)
		-no-meegotouch
		-no-maliit
		-no-contextsubscriber
		-no-meegographicssystem
		-xdamage
		$(use mobility || echo -no)-mobility
	)
	echo "${myconf[@]}"
	"${myconf[@]}"
}
