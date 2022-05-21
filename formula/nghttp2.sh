pkg_set summary "HTTP/2 C Library"
pkg_set webpage "https://nghttp2.org"
pkg_set src.url "https://github.com/nghttp2/nghttp2/releases/download/v1.41.0/nghttp2-1.41.0.tar.xz"
pkg_set src.sha "abc25b8dc601f5b3fefe084ce50fcbdc63e3385621bee0cbfa7b57f9ec3e67c2"
pkg_set license "MIT"
pkg_set depends "libevent libev openssl jansson libxml2 c-ares cunit"
pkg_set bsystem "configure"

build() {
    configure \
        --enable-threads \
        --enable-app \
        --enable-examples \
        --enable-hpack-tools \
        --disable-asio-lib \
        --disable-python-bindings \
        --disable-lib-only \
        --disable-werror \
        --disable-assert \
        --without-systemd \
        --without-jemalloc \
        --with-libxml2 \
        ZLIB_CFLAGS='-lz' \
        ZLIB_LIBS='-lz'
}
