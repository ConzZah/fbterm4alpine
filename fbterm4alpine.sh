#!/usr/bin/env sh

### /// fbterm4alpine.sh // ConzZah // 2026-07-03 00:32 ///

## this script will build fbterm for alpine (we're linking statically ofc)

doso=""
## if we're not root, fill $doso
[ "$(id -u)" = "1000" ] && doso="doas"

$doso apk add build-base pkgconf gpm-dev expat-static zlib-static bzip2-static brotli-static libpng-static freetype-static fontconfig-static ncurses linux-headers git || exit 1

git clone https://github.com/sfzhi/fbterm

cd fbterm || exit 1

make clean

sh configure

make LDFLAGS="-static" LIBS="$(pkg-config --static --libs fontconfig freetype2 expat libpng bzip2)"

$doso make install
