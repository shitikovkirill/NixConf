
{ pkgs ? import <nixpkgs> {} }:

let
  stdenv = pkgs.stdenv;
  dpkg = pkgs.dpkg;
  dynamic-linker = pkgs.stdenv.cc.bintools.dynamicLinker;

  appName = "stacker";
  description = "Multi protocol GUI testing tool";
  desktopItem = pkgs.makeDesktopItem {
    name = appName;
    exec = appName;
    icon = appName;
    comment = description;
    desktopName = "Stacker";
    categories = "Office";
  };

in pkgs.stdenv.mkDerivation rec {
  name = appName;

  src = pkgs.fetchurl {
    url = "https://github.com/lopidio/stacker/releases/download/v0.1.0/stacker_0.1.0_amd64.deb";
    sha256 = "1277kvgnal7f4vml8z7kv8wfhf2zj4sva4n3sbhg708r6aq5rlxa";
  };

  icon = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/lopidio/stacker/master/build/logo-small.png";
    sha256 = "1q9akywy1f1gg770xb9avm4rvcnk300b8qqj0jw202j04f1lg09i";
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
    at-spi2-atk
  ];

  libPathNative = with pkgs; lib.makeLibraryPath packages;
  libPath64 = with pkgs; lib.makeSearchPathOutput "lib" "lib64" packages;
  libPath = "${libPathNative}:${libPath64}";

  rpath = with pkgs; lib.concatStringsSep ":" [
    atomEnv.libPath
    targetPath
    "${targetPath}/opt/stacker/"
    libPath
  ];

  fixupPhase = ''
    patchelf \
    --set-interpreter "${dynamic-linker}" \
    --set-rpath "${rpath}" \
    ${targetPath}/opt/stacker/stacker

    mkdir -p $out/bin
    ln -s ${targetPath}/opt/stacker/stacker $out/bin/stacker
  '';

  meta = with stdenv.lib; {
    inherit description;
    homepage = https://lopidio.github.io/stacker;
    license = licenses.agpl3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ shitikovkirill ];
  };
}
