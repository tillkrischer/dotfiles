install_openjdk() {
  install_archive_prefix \
    "openjdk" \
    "21.0.7" \
    "https://aka.ms/download-jdk/microsoft-jdk-21.0.7-macos-aarch64.tar.gz" \
    "dfc5ed1e8ef5042bba8aaa780fafa835da88f40bb7f9b9192b4bfeb22efc363d" \
    "jdk-21.0.7+6/Contents/Home" \
    "bin/java:java,bin/javac:javac,bin/jar:jar"
}
