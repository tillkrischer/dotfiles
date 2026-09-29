install_cliamp() (
  # Upstream's macOS binary links to Homebrew codecs. Build private copies
  # and relocate the binary so this installation needs no Homebrew.
  codec_prefix="$TMP_DIR/cliamp-codecs"
  cliamp_stage="$TMP_DIR/cliamp-stage"
  cliamp_dest="$LOCAL_DIR/opt/cliamp-2.2.0"
  mkdir -p "$codec_prefix" "$cliamp_stage/lib"

  build_cliamp_codec() (
    package="$1"
    source_url="$2"
    checksum="$3"
    shift 3
    source_archive="$TMP_DIR/${source_url##*/}"
    download_and_verify "$source_url" "$checksum" "$source_archive"
    tar -xf "$source_archive" -C "$TMP_DIR"
    cd "$TMP_DIR/$package"
    # Vorbis 1.3.7 hardcodes a flag removed from Apple's linker.
    if [ "$package" = libvorbis-1.3.7 ]; then
      sed -i '' 's/-force_cpusubtype_ALL//g' configure
    fi
    export CPPFLAGS="-I$codec_prefix/include"
    export LDFLAGS="-L$codec_prefix/lib"
    ./configure --prefix="$codec_prefix" --enable-shared --disable-static "$@"
    make -j"$(sysctl -n hw.ncpu)"
    make install
  )

  build_cliamp_codec libogg-1.3.6 \
    https://downloads.xiph.org/releases/ogg/libogg-1.3.6.tar.xz \
    5c8253428e181840cd20d41f3ca16557a9cc04bad4a3d04cce84808677fa1061
  build_cliamp_codec libvorbis-1.3.7 \
    https://downloads.xiph.org/releases/vorbis/libvorbis-1.3.7.tar.xz \
    b33cc4934322bcbf6efcbacf49e3ca01aadbea4114ec9589d1b1e9d20f72954b \
    --with-ogg="$codec_prefix"
  build_cliamp_codec flac-1.5.0 \
    https://downloads.xiph.org/releases/flac/flac-1.5.0.tar.xz \
    f2c1c76592a82ffff8413ba3c4a1299b6c7ab06c734dee03fd88630485c2b920 \
    --with-ogg="$codec_prefix" --disable-cpplibs --disable-programs --disable-examples
  build_cliamp_codec mpg123-1.33.4 \
    https://www.mpg123.de/download/mpg123-1.33.4.tar.bz2 \
    3ae8c9ff80a97bfc0e22e89fbcd74687eca4fc1db315b12607f27f01cb5a47d9 \
    --disable-components --enable-libmpg123 --disable-network

  for dylib in libogg.0.dylib libvorbis.0.dylib libvorbisenc.2.dylib libFLAC.14.dylib libmpg123.0.dylib; do
    cp -L "$codec_prefix/lib/$dylib" "$cliamp_stage/lib/$dylib"
    install_name_tool -id "@loader_path/$dylib" "$cliamp_stage/lib/$dylib"
  done
  download_and_verify \
    "https://github.com/bjarneo/cliamp/releases/download/v2.2.0/cliamp-darwin-arm64" \
    "52210e7a8aeac519154b9c556851684a3be63e54d88ae78c61c9f5ec690849f3" \
    "$cliamp_stage/cliamp"
  chmod +x "$cliamp_stage/cliamp"

  for binary in "$cliamp_stage"/lib/*.dylib "$cliamp_stage/cliamp"; do
    if [ "$binary" = "$cliamp_stage/cliamp" ]; then
      relative_libs='@loader_path/lib'
    else
      relative_libs='@loader_path'
    fi
    otool -L "$binary" | awk 'NR > 1 {print $1}' | while IFS= read -r dependency; do
      case "$dependency" in
        /opt/homebrew/*|"$codec_prefix"/*)
          library=${dependency##*/}
          test -f "$cliamp_stage/lib/$library"
          install_name_tool -change "$dependency" "$relative_libs/$library" "$binary"
          ;;
      esac
    done
    codesign --force --sign - "$binary"
  done

  # Verify before replacing the current installation.
  "$cliamp_stage/cliamp" --version
  mkdir -p "$cliamp_dest"
  cp -R "$cliamp_stage"/. "$cliamp_dest"/
  link_bin "$cliamp_dest/cliamp" cliamp
)
