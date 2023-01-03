# ppkg-formula-repository
the offical formula repository for [ppkg](https://github.com/leleliu008/ppkg)

## what's formula
a formula is a YAML format file which is used to configure a ppkg's package infomation and describe how to compile a package for [ppkg](https://github.com/leleliu008/ppkg).

|KEY|required?|overview|
|-|-|-|
|`summary`|required|the summary of this package.|
|`license`|optional|the license of this package.<br>a list of space-separated [SPDX license short identifiers](https://spdx.github.io/spdx-spec/v2.3/SPDX-license-list/#a1-licenses-with-short-identifiers)|
|`version`|optional|the version of this package.<br>If this key is not present, it will be calculated from `src-url`, if `src-url` is also not present, it will be calculated from running time as format `date +%Y.%m.%d`|
||||
|`web-url`|optional|the home webpage of this package.<br>If this key is not present, `git-url` must be present.|
||||
|`git-url`|optional|the source code git repository.<br>must end with `.git`|
|`git-ref`|optional|reference: https://git-scm.com/book/en/v2/Git-Internals-Git-References <br>example values: `HEAD` `refs/heads/master` `refs/heads/main` `refs/tags/v1`, default value is `HEAD`|
|`git-sha`|optional|the full git commit id, 40-byte hexadecimal string, if `git-ref` and `git-sha` both are given, `git-sha` takes precedence over `git-ref`|
|`shallow`|optional|whether do a git shallow fetch. values can be `yes` or `no`. default value is `yes`.|
||||
|`src-url`|optional|the source code download url of this package.<br>must end with one of `.zip` `.tar.xz` `.tar.gz` `.tar.lz` `.tar.bz2` `.tgz` `.txz` `.tlz` `.c` `.cc` `.cxx` `.cpp`.<br>also support format like `dir://DIR`|
|`src-uri`|optional|the mirror of `src-url`.|
|`src-sha`|optional|the `sha256sum` of source code.<br>`src-sha` and `src-url` must appear togther.|
||||
|`fix-url`|optional|the patch file download url of this package.<br>must end with one of `.diff` `.patch` `.zip` `.tar.xz` `.tar.gz` `.tar.lz` `.tar.bz2` `.tgz` `.txz` `.tlz`|
|`fix-sha`|optional|the `sha256sum` of patch file.<br>`src-sha` and `src-url` must appear togther.|
||||
|`res-url`|optional|other resource download url of this package.<br>must end with one of `.diff` `.patch` `.zip` `.tar.xz` `.tar.gz` `.tar.lz` `.tar.bz2` `.tgz` `.txz` `.tlz` |
|`res-sha`|optional|the `sha256sum` of resource file.<br>`src-sha` and `src-url` must appear togther.|
||||
|`dep-pkg`|optional|space-separated   `ppkg packages` that are depended by this package when installing and/or runtime, which will be installed via [ppkg](https://github.com/leleliu008/ppkg).|
|`dep-upp`|optional|space-separated   `uppm packages` that are depended by this package when installing and/or runtime, which will be installed via [uppm](https://github.com/leleliu008/uppm).|
|`dep-pym`|optional|space-separated `python packages` that are depended by this package when installing and/or runtime, which will be installed via `pip3`.|
|`dep-plm`|optional|space-separated    `perl modules` that are depended by this package when installing and/or runtime, which will be installed via `cpan`.|
||||
|`cdefine`|optional|append to `CPPFLAGS`|
|`ccflags`|optional|append to `CFLAGS`|
|`xxflags`|optional|append to `CXXFLAGS`|
|`ldflags`|optional|append to `LDFLAGS`|
||||
|`toolset`|optional|C and C++ toolchain name.<br>values can be `system` `gcc` `llvm` `zig`. `system` means follow system. If this key is not present, `zig` will be used. this key only affects GNU/Linux system.|
|`cstdlib`|optional|C standard library name.<br>values can be `system` `glibc` `musl-libc`. `system` means follow system. If this key is not present, `musl-libc` will be used. this key only affects GNU/Linux system.|
|`exetype`|optional|indicates whether can be built statically-linked executable.<br>values can be `statically-linked` `dynamically-linked`. If this key is not present, `statically-linked` will be used. this key only affects `GNU/Linux` system.|
||||
|`bsystem`|optional|build system.<br>values can be `autogen` `autotools` `configure` `cmake` `cmake-gmake` `cmake-ninja` `meson` `xmake` `gmake` `ninja` `cargo` `go`|
|`bscript`|optional|the directory where the build script is located in, relative to `PACKAGE_INSTALLING_TOP_DIR`. build script such as `configure`, `Makefile`, `CMakeLists.txt`, `meson.build`, `Cargo.toml`, etc.|
|`binbstd`|optional|whether build in the directory where the build script is located in, otherwise build in other directory. values can be `yes` or `no`. default value is `no`.|
|`prepare`|optional|bash shell code to be run before `install`. `pwd` is `PACKAGE_INSTALLING_BST_DIR`|
|`install`|optional|bash shell code to be run when user run `ppkg install <PKG>`. If this key is not present, I will run default install code according to `bsystem`|
|`symlink`|optional|whether symlink installed files to `/opt/ppkg/symlinked/*`. values can be `yes` or `no`. default value is `yes`.|

## the commands can be invoked in prepare and install block
|command|usage-example|
|-|-|
|`echo`|`echo 'your message.'`|
|`info`|`info 'your infomation.'`|
|`warn`|`warn "no package manager found."`|
|`error`|`error 'error message.'`|
|`die`|`die "please specify a package name."`|
|`success`|`success "build success."`|
|`sed_in_place`|`sed_in_place 's/-mandroid//g' Configure`|
|`format_unix_timestamp`|`format_unix_timestamp "$TIMESTAMP_UNIX" '+%Y/%m/%d %H:%M:%S'`|
|`getvalue`|`VALUE=$(getvalue --key=value)`|
|`sha256sum`|`VALUE=$(sha256sum FILEPATH)`|
|`is_sha256sum_match`|`is_sha256sum_match FILEPATH SHA256SUM`|
|`fetch`|`fetch URL [--sha256=SHA256] --output-path=PATH`<br>`fetch URL [--sha256=SHA256] --output-dir=DIR --output-name=NAME`<br>`fetch URL [--sha256=SHA256] --output-dir=DIR [--output-name=NAME]`<br>`fetch URL [--sha256=SHA256] [--output-dir=DIR] --output-name=NAME`|

## the commands can be invoked in install block only
|command|usage-example|
|-|-|
|`configure`|`configure --enable-pic`|
|`mesonw`|`mesonw -Dneon=disabled -Darm-simd=disabled`|
|`cmakew`|`cmakew -DBUILD_SHARED_LIBS=ON -DBUILD_STATIC_LIBS=ON`|
|`gmakew`|`gmakew`|
|`xmakew`|`xmakew`|
|`cargow`|`cargow`|
|`gow`|`gow`|

## the variable can be used in prepare and install block
|variable|overview|
|-|-|
|`NATIVE_OS_TYPE`|current machine os type.|
|`NATIVE_OS_NAME`|current machine os name.|
|`NATIVE_OS_VERS`|current machine os version.|
|`NATIVE_OS_ARCH`|current machine os arch.|
|||
|`MY_VERSION`|the version of `ppkg`.|
|`MY_HOME_DIR`|the home directory of `ppkg`.|
|`MY_HOME_PAGE`|the home webpage of `ppkg`.|
|`MY_CACHED_DIR`|the downloads directory of `ppkg`.|
|`MY_INSTALL_DIR`|the installed directory of `ppkg`.|
|||
|`CC`|the C Compiler.|
|`CFLAGS`|the flags of `CC`.|
|`CXX`|the C++ Compiler.|
|`CXXFLAGS`|the flags of `CXX`.|
|`CPP`|the C/C++ PreProcessor.|
|`CPPFLAGS`|the flags of `CPP`.|
|`AS`|the assembler.|
|`AR`|the archiver.|
|`RANLIB`|the archiver extra tool.|
|`LD`|the linker.|
|`LDFLAGS`|the flags of `LD`.|
|`NM`|a command line tool to list symbols from object files.|
|`STRIP`|a command line tool to discard symbols and other data from object files.|
|||
|`TIMESTAMP_UNIX`|the unix timestamp of this installation.|
|||
|`PACKAGE_INSTALLING_TOP_DIR`|the directory used when installing.|
|`PACKAGE_INSTALLING_SRC_DIR`|the directory where the source code tarball uncompressed to or copy to.|
|`PACKAGE_INSTALLING_BST_DIR`|the directory where the build script (`Makefile`, `configure`, `CMakeLists.txt`, `meson.build`, `Cargo.toml`) is located in.|
|`PACKAGE_INSTALLING_TMP_DIR`|the directory where the tmp files are stored in when run build script.|
|||
|`PACKAGE_INSTALL_DIR`|the directory where the output files will be installed to.|
|||
|`x_INSTALL_DIR`|the installation directory of x package.|
|`x_INCLUDE_DIR`|`$x_INSTALL_DIR/include`|
|`x_LIBRARY_DIR`|`$x_INSTALL_DIR/lib`|
