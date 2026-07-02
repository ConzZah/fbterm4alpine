#!/usr/bin/env sh

### /// fbterm4alpine.sh // ConzZah // 2026-07-02 04:42 ///

## this script will build fbterm for alpine (we're linking statically ofc)

apk add build-base pkgconf gpm-dev expat-static zlib-static bzip2-static brotli-static libpng-static freetype-static fontconfig-static linux-headers git

git clone https://github.com/sfzhi/fbterm

cd fbterm || exit 1

make clean

ldflags="$(pkg-config --static --libs fontconfig freetype2 expat libpng bzip2)"

./configure LDFLAGS="-static $ldflags"

make LDFLAGS="-static $ldflags" LIBS="$ldflags"

make install
