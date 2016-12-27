include Makefile.config

all: test

test: init-repo org.ppsspp.PPSSPP.json
	flatpak-builder --force-clean --repo=repo --ccache --require-changes builddir org.ppsspp.PPSSPP.json
	flatpak build-update-repo repo

release: init-release-repo org.ppsspp.PPSSPP.json
	flatpak-builder --force-clean --repo=release-repo --ccache --gpg-sign=${RELEASE_GPG_KEY} builddir org.ppsspp.PPSSPP.json
	flatpak build-update-repo --generate-static-deltas --gpg-sign=${RELEASE_GPG_KEY} release-repo

test-master: init-repo org.ppsspp.PPSSPP.master.json
	flatpak-builder --force-clean --repo=repo --ccache --require-changes builddir org.ppsspp.PPSSPP.master.json
	flatpak build-update-repo repo

release-master: init-release-repo org.ppsspp.PPSSPP.master.json
	flatpak-builder --force-clean --repo=release-repo --ccache --gpg-sign=${RELEASE_GPG_KEY} builddir org.ppsspp.PPSSPP.master.json
	flatpak build-update-repo --generate-static-deltas --gpg-sign=${RELEASE_GPG_KEY} release-repo

init-repo:
	ostree init --mode=archive-z2 --repo=repo

init-release-repo:
	ostree init --mode=archive-z2 --repo=release-repo

ppsspp.flatpakref: ppsspp.flatpakref.in
	sed -e 's|@URL@|${URL}|g' -e 's|@GPG@|$(shell gpg --export ${RELEASE_GPG_KEY} | base64 | tr -d '\n')|' $< > $@
