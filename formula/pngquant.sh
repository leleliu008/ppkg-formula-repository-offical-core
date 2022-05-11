pkg_set summary "PNG image optimizing utility"
pkg_set webpage "https://pngquant.org"
pkg_set src.url "https://pngquant.org/pngquant-2.12.5-src.tar.gz"
pkg_set src.sha "3638936cf6270eeeaabcee42e10768d78e4dc07cac9310307835c1f58b140808"
pkg_set dep.cmd "pkg-config"
pkg_set dep.pkg "libpng lcms2"
pkg_set bsystem "make"
pkg_set binbstd 'YES'

build() {
    run ./configure \
        --prefix="$PACKAGE_INSTALL_DIR" \
        --disable-sse \
        --with-libpng="$libpng_INSTALL_DIR" \
        CC="$CC" \
        CFLAGS="\"$CFLAGS $CPPFLAGS -static\"" \
        LDFLAGS="\"$LDFLAGS\"" &&
    makew clean &&
    makew install
}
