{ pkgs ? import <nixpkgs> { } }:

let
  stdenv = pkgs.stdenv;
  dpkg = pkgs.dpkg;
  dynamic-linker = stdenv.cc.bintools.dynamicLinker;

  appName = "graphql-playground";
  description = "GraphQL IDE for better development workflows";
  desktopItem = pkgs.makeDesktopItem {
    name = appName;
    exec = appName;
    icon = appName;
    comment = description;
    desktopName = "GraphQL playground";
    categories = "Development";
  };
in stdenv.mkDerivation rec {
  name = appName;

  src = pkgs.fetchurl {
    url =
      "https://github.com/prisma/graphql-playground/releases/download/v1.8.10/graphql-playground-electron_1.8.10_amd64.deb";
    sha256 = "0y52jhpp3bllbsbc1jx76zf02cyjfbxh39h99i4bq5frnn38aq0d";
  };

  icon = pkgs.fetchurl {
    url =
      "https://electronjs.org/app-img/graphql-playground/graphql-playground-icon-128.png";
    sha256 = "0465b74zigz8zcaswv7jhkmvcziwciapfcw2scvs9k1i4hmk3nx8";
  };

  phases = "unpackPhase fixupPhase";

  unpackPhase = ''
    mkdir -p $out
    ${dpkg}/bin/dpkg -x $src $out

    mkdir -p $out/share/{applications,icons/hicolor/scalable/apps}
    ln -s $icon $out/share/icons/hicolor/scalable/apps/${appName}.png
    cp ${desktopItem}/share/applications/* $out/share/applications
  '';

  packages = with pkgs; [ at-spi2-atk ];

  libPathNative = with pkgs; lib.makeLibraryPath packages;
  libPath64 = with pkgs; lib.makeSearchPathOutput "lib" "lib64" packages;
  libPath = "${libPathNative}:${libPath64}";

  rpath = with pkgs;
    lib.concatStringsSep ":" [
      atomEnv.libPath
      "$out/opt/GraphQL Playground/"
      libPath
    ];

  fixupPhase = ''
    ls -la $out/opt/GraphQL\ Playground/

    patchelf \
    --set-interpreter "${dynamic-linker}" \
    --set-rpath "${rpath}" \
    $out/opt/GraphQL\ Playground/graphql-playground-electron

    mkdir -p $out/bin
    ln -s $out/opt/GraphQL\ Playground/graphql-playground-electron $out/bin/graphql-playground
  '';

  meta = with stdenv.lib; {
    inherit description;
    homepage = "https://github.com/prisma/graphql-playground";
    license = licenses.agpl3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ shitikovkirill ];
  };
}
