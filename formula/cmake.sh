pkg_set summary "Cross-platform make"
pkg_set webpage "https://www.cmake.org"
pkg_set git.url "https://github.com/Kitware/CMake.git"
pkg_set src.url "https://github.com/Kitware/CMake/releases/download/v3.23.1/cmake-3.23.1.tar.gz"
pkg_set src.sha "33fd10a8ec687a4d0d5b42473f10459bb92b3ae7def2b745dc10b192760869f3"
pkg_set license "BSD-3-Clause"
pkg_set depends "ncurses openssl"
pkg_set bsystem "gmake"
pkg_set binbstd "yes"

build() {
    run ./bootstrap \
        --prefix=$PACKAGE_INSTALL_DIR \
        --no-system-libs \
        --parallel=$BUILD_NJOBS \
        -- \
        -DCMake_BUILD_LTO=ON \
        -DBUILD_QtDialog=OFF \
        -DBUILD_CursesDialog=ON \
        -DCMAKE_USE_OPENSSL=ON \
        -DOPENSSL_USE_STATIC_LIBS=ON &&
    gmakew &&
    gmakew install
}
