# Flatpak package for PPSSPP

This repository tracks files for building a [Flatpak][1] package with either
the latest stable release or the latest commit of [PPSSPP][2], a free and open
source PSP emulator. While some distributions include it in repositories, the
project is quite opinionated about handling linking external dependencies
dynamically, making it perfect fit for Flatpak.

## Installation instructions
Somewhere down the road I plan to publish a Flatpak remote with automatic
nightly builds, but for now you can download the latest stable and a relatively
fresh nightly build from GitHub Releases page [here][3].

```sh
flatpak --user remote-add gnome https://sdk.gnome.org/gnome.flatpakrepo
flatpak --user install --bundle ppsspp-1.3.flatpak
flatpak run org.ppsspp.PPSSPP # or just applications menu
```

## To-do and issues
PPSSPP alone works like a charm. The only thing to implement in this
flatpak is AppStream information – partially done in [appstream branch][4].

While working on flatpacking PPSSPP, I reported few issues against Flatpak itself:
* Add option to disable 'make install' invocation (flatpak/flatpak#458)
* Multiple branches of application overwrite each other desktop launcher (flatpak/flatpak#460)
* Support for Ninja generator in CMake (flatpak/flatpak#461)
* Upgrade yocto submodule and publish new SDK version (flatpak/freedesktop-sdk-base#2)

One problem I didn't look at yet is SVG icon support in AppStream data, which
seems to be broken.

[1]: http://flatpak.org/
[2]: http://ppsspp.org/
[3]: https://github.com/Barthalion/flatpak-ppsspp/releases
[4]: https://github.com/Barthalion/flatpak-ppsspp/tree/appstream
