# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo desktop xdg

DESCRIPTION="A multi-platform launcher for your anime games"
HOMEPAGE="https://github.com/TwintailTeam/TwintailLauncher"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/TwintailTeam/TwintailLauncher.git"
else
	SRC_URI="https://github.com/TwintailTeam/TwintailLauncher/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64"
	S="${WORKDIR}/TwintailLauncher-ttl-v${PV}"
fi

LICENSE="GPL-3"
SLOT="0"

RESTRICT="network-sandbox"
PROPERTIES="live"

BDEPEND="
	|| ( >=dev-lang/rust-bin-1.70:* >=dev-lang/rust-1.70:* )
	net-libs/nodejs
	sys-apps/yarn
	sys-devel/binutils
	dev-vcs/git
	sys-apps/pnpm-bin
"

RDEPEND="
	dev-libs/glib:2
	dev-libs/atk
	net-libs/webkit-gtk:4.1
	x11-libs/cairo
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:3
	x11-libs/pango
	dev-libs/libayatana-appindicator
"

DEPEND="${RDEPEND}"

QA_FLAGS_IGNORED="usr/bin/twintaillauncher"

src_unpack() {
	if [[ ${PV} == *9999* ]]; then
		git-r3_src_unpack
	else
		default
	fi
}

src_prepare() {
	default
	pnpm install || die "pnpm install failed"
}

src_compile() {
	pnpm build:native --no-bundle || die "Frontend build failed"
}

src_install() {
	# Binary
	dobin "src-tauri/target/release/twintaillauncher"

	# Resources/Sidecars
	insinto /usr/lib/twintaillauncher/resources
	exeinto /usr/lib/twintaillauncher/resources
	doexe "src-tauri/target/release/resources/hpatchz"
	doexe "src-tauri/target/release/resources/7zr"
	doexe "src-tauri/target/release/resources/reaper"
	doins "src-tauri/target/release/resources/hkrpg_patch.dll"

	# Desktop file
	domenu "twintaillauncher.desktop"

	# Icons
	doicon -s 32 "src-tauri/icons/32x32.png"
	doicon -s 128 "src-tauri/icons/128x128.png"
	
	# License
	dodoc LICENSE
}