
{ pkgs ? import <nixpkgs> {} }:

let
  stdenv = pkgs.stdenv;
  dpkg = pkgs.dpkg;
  dynamic-linker = pkgs.stdenv.cc.bintools.dynamicLinker;

  appName = "dockstation";
  description = "DockStation is developer-centric application to managing projects based on Docker.";
  desktopItem = pkgs.makeDesktopItem {
    name = appName;
    exec = appName;
    icon = appName;
    comment = description;
    desktopName = "DockStation";
    categories = "Office";
  };
in pkgs.stdenv.mkDerivation rec {
  name = appName;

  src = pkgs.fetchurl {
    url = "https://github.com/DockStation/dockstation/releases/download/v1.5.1/dockstation_1.5.1_amd64.deb";
    sha256 = "09pj1sjr6djh5fccak41jk8lia96b18r85cpqf39gbyfdxx0bg5b";
  };

  icon = pkgs.fetchurl {
    url = "https://dockstation.io/images/video_preview.png";
    sha256 = "03092xiw0ka3zafkgdwz2vslmmb06xps3g4n47sg1gj19lnbdimp";
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
    at-spi2-atk utillinux
  ];

  libPathNative = with pkgs; lib.makeLibraryPath packages;
  libPath64 = with pkgs; lib.makeSearchPathOutput "lib" "lib64" packages;
  libPath = "${libPathNative}:${libPath64}";

  rpath = with pkgs; lib.concatStringsSep ":" [
    atomEnv.libPath
    "${targetPath}/opt/DockStation/"
    libPath
  ];

  fixupPhase = ''
    patchelf \
    --set-interpreter "${dynamic-linker}" \
    --set-rpath "${rpath}" \
    ${targetPath}/opt/DockStation/dockstation

    mkdir -p $out/bin
    ln -s ${targetPath}/opt/DockStation/dockstation $out/bin/dockstation
  '';

  meta = with stdenv.lib; {
    inherit description;
    homepage = https://dockstation.io/;
    license = licenses.agpl3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ shitikovkirill ];
  };
}
