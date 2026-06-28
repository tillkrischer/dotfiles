download_and_verify() {
  url="$1"
  sha256="$2"
  output="$3"

  curl -L "$url" -o "$output"
  actual=$(shasum -a 256 "$output" | awk '{print $1}')

  if [ "$actual" != "$sha256" ]; then
    echo "sha256 mismatch for $url" >&2
    echo "expected: $sha256" >&2
    echo "actual:   $actual" >&2
    exit 1
  fi
}

extract_archive() {
  archive="$1"
  dest="$2"

  mkdir -p "$dest"

  case "$archive" in
    *.tar.gz|*.tgz)
      tar -xzf "$archive" -C "$dest"
      ;;
    *.zip)
      unzip -q "$archive" -d "$dest"
      ;;
    *)
      echo "unsupported archive: $archive" >&2
      exit 1
      ;;
  esac
}

link_bin() {
  target="$1"
  name="$2"

  ln -sfn "$target" "$LOCAL_DIR/bin/$name"
}

install_archive_binary() {
  name="$1"
  version="$2"
  url="$3"
  sha256="$4"
  source_path="$5"
  bin_name="$6"

  archive="$TMP_DIR/${name}-${version}-${url##*/}"
  extract_dir="$TMP_DIR/extract-$name-$version"
  install_dir="$LOCAL_DIR/opt/$name-$version"

  download_and_verify "$url" "$sha256" "$archive"
  rm -rf "$extract_dir" "$install_dir"
  extract_archive "$archive" "$extract_dir"
  mkdir -p "$install_dir"
  cp "$extract_dir/$source_path" "$install_dir/$bin_name"
  chmod +x "$install_dir/$bin_name"
  link_bin "$install_dir/$bin_name" "$bin_name"
}

install_archive_prefix() {
  name="$1"
  version="$2"
  url="$3"
  sha256="$4"
  prefix_path="$5"
  link_specs="$6"

  archive="$TMP_DIR/${name}-${version}-${url##*/}"
  extract_dir="$TMP_DIR/extract-$name-$version"
  install_dir="$LOCAL_DIR/opt/$name-$version"

  download_and_verify "$url" "$sha256" "$archive"
  rm -rf "$extract_dir" "$install_dir"
  extract_archive "$archive" "$extract_dir"
  mkdir -p "$install_dir"

  if [ "$prefix_path" = "." ]; then
    cp -R "$extract_dir"/. "$install_dir"/
  else
    cp -R "$extract_dir/$prefix_path"/. "$install_dir"/
  fi

  for spec in $(printf '%s' "$link_specs" | tr ',' ' '); do
    source_path=${spec%%:*}
    bin_name=${spec#*:}
    chmod +x "$install_dir/$source_path"
    link_bin "$install_dir/$source_path" "$bin_name"
  done
}

install_raw_binary() {
  name="$1"
  version="$2"
  url="$3"
  sha256="$4"
  bin_name="$5"

  install_dir="$LOCAL_DIR/opt/$name-$version"
  output="$install_dir/$bin_name"

  rm -rf "$install_dir"
  mkdir -p "$install_dir"
  download_and_verify "$url" "$sha256" "$output"
  chmod +x "$output"
  link_bin "$output" "$bin_name"
}

copy_app() {
  source_app="$1"
  target_app="$APP_DIR/$(basename "$source_app")"

  rm -rf "$target_app"
  ditto "$source_app" "$target_app"
}

install_app_zip() {
  name="$1"
  version="$2"
  url="$3"
  sha256="$4"
  app_path="$5"

  archive="$TMP_DIR/${name}-${version}-${url##*/}"
  extract_dir="$TMP_DIR/extract-$name-$version"

  download_and_verify "$url" "$sha256" "$archive"
  rm -rf "$extract_dir"
  extract_archive "$archive" "$extract_dir"
  copy_app "$extract_dir/$app_path"
}

install_app_dmg() {
  name="$1"
  version="$2"
  url="$3"
  sha256="$4"
  app_path="$5"

  archive="$TMP_DIR/${name}-${version}-${url##*/}"
  mount_dir="$TMP_DIR/mount-$name-$version"

  download_and_verify "$url" "$sha256" "$archive"
  mkdir -p "$mount_dir"
  hdiutil attach "$archive" -nobrowse -readonly -mountpoint "$mount_dir" >/dev/null
  if copy_app "$mount_dir/$app_path"; then
    hdiutil detach "$mount_dir" >/dev/null
  else
    status=$?
    hdiutil detach "$mount_dir" >/dev/null || true
    exit "$status"
  fi
}
