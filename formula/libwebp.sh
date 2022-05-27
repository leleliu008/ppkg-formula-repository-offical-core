pkg_set summary "Image format providing lossless and lossy compression for web images"
pkg_set webpage "https://developers.google.com/speed/webp"
pkg_set git.url "https://github.com/webmproject/libwebp.git"
pkg_set src.url "http://downloads.webmproject.org/releases/webp/libwebp-1.2.2.tar.gz"
pkg_set src.sha "7656532f837af5f4cec3ff6bafe552c044dc39bf453587bd5b77450802f4aee6"
pkg_set depends "libpng libtiff libjpeg-turbo giflib"
pkg_set ldflags "-llzma -lzstd"
pkg_set bsystem "cmake"
