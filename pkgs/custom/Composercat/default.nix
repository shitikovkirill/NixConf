
{ pkgs ? import <nixpkgs> {} }:

let
  stdenv = pkgs.stdenv;
  dpkg = pkgs.dpkg;
  dynamic-linker = pkgs.stdenv.cc.bintools.dynamicLinker;

  appName = "composercat";
  description = "Graphical interface for Composer (PHP)";
  desktopItem = pkgs.makeDesktopItem {
    name = appName;
    exec = appName;
    icon = appName;
    comment = description;
    desktopName = "Сomposercat";
    categories = "Development";
  };
in pkgs.stdenv.mkDerivation rec {
  name = appName;

  src = pkgs.fetchurl {
    url = "http://downloads.getcomposercat.com/composercat/composercat_0.4.0_amd64.deb";
    sha256 = "1qvqvms6g2rwmll90zidv9dh0m0xvmhjzvgsv2yhh1k33bpdfayx";
  };

  icon = pkgs.fetchurl {
    url = "https://downloads.getcomposercat.com/img/logo.png";
    sha256 = "19whlf4h6mmw661f0k3m482bh61awhb687z8s0yviqr45g0l4wwp";
  };

  phases = "unpackPhase fixupPhase";

  targetPath = "$out";

  unpackPhase = ''
    mkdir -p ${targetPath}
    ${dpkg}/bin/dpkg -x $src ${targetPath}

    mkdir -p $out/share/{applications,icons/hicolor/scalable/apps}
    ln -s $icon $out/share/icons/hicolor/scalable/apps/${appName}.png
    cp ${desktopItem}/share/applications/* $out/share/applications
  '';

  packages = with pkgs; [
    at-spi2-atk gtk2
  ];

  libPathNative = with pkgs; lib.makeLibraryPath packages;
  libPath64 = with pkgs; lib.makeSearchPathOutput "lib" "lib64" packages;
  libPath = "${libPathNative}:${libPath64}";

  rpath = with pkgs; lib.concatStringsSep ":" [
    atomEnv.libPath
    "${targetPath}/opt/Composercat/"
    libPath
  ];

  fixupPhase = ''
    patchelf \
    --set-interpreter "${dynamic-linker}" \
    --set-rpath "${rpath}" \
    ${targetPath}/opt/Composercat/composercat

    mkdir -p $out/bin
    ln -s ${targetPath}/opt/Composercat/composercat $out/bin/composercat
  '';

  meta = with stdenv.lib; {
    inherit description;
    homepage = https://downloads.getcomposercat.com/;
    license = licenses.agpl3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ shitikovkirill ];
  };
}
