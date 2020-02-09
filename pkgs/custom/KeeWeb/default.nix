{ pkgs ? import <nixpkgs> { } }:

let
  stdenv = pkgs.stdenv;
  dpkg = pkgs.dpkg;
  dynamic-linker = pkgs.stdenv.cc.bintools.dynamicLinker;

  description = "Free cross-platform password manager compatible with KeePass ";
  desktopItem = pkgs.makeDesktopItem {
    name = "KeeWeb";
    exec = "keeweb";
    icon = "keeweb";
    comment = description;
    desktopName = "Keep passwords";
    categories = "Office";
  };

in pkgs.stdenv.mkDerivation rec {
  name = "keeweb";

  src = pkgs.fetchurl {
    url =
      "https://github.com/keeweb/keeweb/releases/download/v1.8.2/KeeWeb-1.8.2.linux.x64.deb";
    sha256 = "17frvq4hzybxpczpjv93m1fvs0q0wxprw30kvwps5zhrxf8wmp3y";
  };

  icon = pkgs.fetchurl {
    url =
      "https://raw.githubusercontent.com/keeweb/keeweb/master/desktop/icon.png";
    sha256 = "a0c03adaf79ad7d9af53447cac3746d687daf9a8ce19de7e4d92dc36d1d474a9";
  };

  phases = "unpackPhase fixupPhase";

  targetPath = "$out";

  unpackPhase = ''
    mkdir -p ${targetPath}
    ${dpkg}/bin/dpkg -x $src ${targetPath}

    mkdir -p $out/share/{applications,icons/hicolor/scalable/apps}
    ln -s $icon $out/share/icons/hicolor/scalable/apps/keeweb.png
    cp ${desktopItem}/share/applications/* $out/share/applications
  '';

  packages = with pkgs; [ at-spi2-atk utillinux ];

  libPathNative = with pkgs; lib.makeLibraryPath packages;
  libPath64 = with pkgs; lib.makeSearchPathOutput "lib" "lib64" packages;
  libPath = "${libPathNative}:${libPath64}";

  rpath = with pkgs;
    lib.concatStringsSep ":" [
      atomEnv.libPath
      "${targetPath}/opt/keeweb-desktop/"
      libPath
    ];

  fixupPhase = ''
    patchelf \
    --set-interpreter "${dynamic-linker}" \
    --set-rpath "${rpath}" \
    ${targetPath}/opt/keeweb-desktop/KeeWeb

    mkdir -p $out/bin
    ln -s ${targetPath}/opt/keeweb-desktop/KeeWeb $out/bin/keeweb
  '';

  meta = with stdenv.lib; {
    inherit description;
    homepage = "https://keeweb.info";
    license = licenses.mit;
    maintainers = with maintainers; [ shitikovkirill ];
    platforms = platforms.x86_64;
  };
}
