
{ pkgs ? import <nixpkgs> {} }:

let
  stdenv = pkgs.stdenv;
  dpkg = pkgs.dpkg;
  dynamic-linker = stdenv.cc.bintools.dynamicLinker;

  appName = "snipline";
  description = "Store your complex commands with dynamic parameters for easy retrieval with a fast workflow in mind.";
  desktopItem = pkgs.makeDesktopItem {
    name = appName;
    exec = appName;
    icon = appName;
    comment = description;
    desktopName = "Snipline";
    categories = "Development";
  };
in stdenv.mkDerivation rec {
  name = appName;

  src = pkgs.fetchurl {
    url = "https://desktop.downloads.snipline.io/download/0.7.0/linux_64/snipline_0.7.0_amd64.deb";
    sha256 = "13l2yg3429yqf6rcs7vhww84z3g9lwfair8mxl3a04lfmhk4l4ig";
  };

  icon = pkgs.fetchurl {
    url = "https://app.snipline.io/images/snipline-inverted-logo.svg";
    sha256 = "10vfxx0qyvm00kb3ajfi42s0xa3xdj9vsl55vzk3wl0byqj0ls8q";
  };

  phases = "unpackPhase fixupPhase";

  unpackPhase = ''
    mkdir -p $out
    ${dpkg}/bin/dpkg -x $src $out

    mkdir -p $out/share/{applications,icons/hicolor/scalable/apps}
    ln -s $icon $out/share/icons/hicolor/scalable/apps/${appName}.svg
    cp ${desktopItem}/share/applications/* $out/share/applications
  '';

  packages = with pkgs; [
    at-spi2-atk
  ];

  libPathNative = with pkgs; lib.makeLibraryPath packages;
  libPath64 = with pkgs; lib.makeSearchPathOutput "lib" "lib64" packages;
  libPath = "${libPathNative}:${libPath64}";

  rpath = with pkgs; lib.concatStringsSep ":" [
    atomEnv.libPath
    "$out/usr/lib/snipline/"
    libPath
  ];

  fixupPhase = ''
    ls -la $out/usr/bin/snipline

    patchelf \
    --set-interpreter "${dynamic-linker}" \
    --set-rpath "${rpath}" \
    $out/usr/bin/snipline

    mkdir -p $out/bin
    ln -s $out/usr/bin/snipline $out/bin/${appName}
  '';

  meta = with stdenv.lib; {
    inherit description;
    homepage = https://github.com/prisma/graphql-playground;
    license = licenses.agpl3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ shitikovkirill ];
  };
}
