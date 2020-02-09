{ pkgs ? import <nixpkgs> { } }:

let
  stdenv = pkgs.stdenv;
  dpkg = pkgs.dpkg;
  dynamic-linker = stdenv.cc.bintools.dynamicLinker;

  appName = "snippetstore";
  description = "A snippet management app for developers";
  desktopItem = pkgs.makeDesktopItem {
    name = appName;
    exec = appName;
    icon = appName;
    comment = description;
    desktopName = "Snippet Store";
    categories = "Development";
  };
in stdenv.mkDerivation rec {
  name = appName;

  src = pkgs.fetchurl {
    url =
      "https://github.com/ZeroX-DG/SnippetStore/releases/download/v0.2.12/snippetstore_0.2.12_amd64.deb";
    sha256 = "0ajq0zwk0vmxgag09yjar4n4b9l835l8fvc7b55myq56jadqzbfp";
  };

  phases = "unpackPhase fixupPhase";

  unpackPhase = ''
    mkdir -p $out
    ${dpkg}/bin/dpkg -x $src $out
    chmod go-w $out
  '';

  packages = with pkgs; [ at-spi2-atk gtk2 ];

  libPathNative = with pkgs; lib.makeLibraryPath packages;
  libPath64 = with pkgs; lib.makeSearchPathOutput "lib" "lib64" packages;
  libPath = "${libPathNative}:${libPath64}";

  rpath = with pkgs;
    lib.concatStringsSep ":" [
      atomEnv.libPath
      "$out/opt/Snippet Store/"
      libPath
    ];

  fixupPhase = ''
    ls -la $out/opt/Snippet\ Store/
    ls -la $out/usr/share/icons/hicolor/512x512/apps/snippetstore.png

    mkdir -p $out/share/{applications,icons/hicolor/scalable/apps}
    ln -s $out/usr/share/icons/hicolor/512x512/apps/snippetstore.png $out/share/icons/hicolor/scalable/apps/${appName}.png
    cp ${desktopItem}/share/applications/* $out/share/applications

    patchelf \
    --set-interpreter "${dynamic-linker}" \
    --set-rpath "${rpath}" \
    $out/opt/Snippet\ Store/snippetstore

    mkdir -p $out/bin
    ln -s $out/opt/Snippet\ Store/snippetstore $out/bin/${appName}
  '';

  meta = with stdenv.lib; {
    inherit description;
    homepage = "https://github.com/ZeroX-DG/SnippetStore";
    license = licenses.agpl3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ shitikovkirill ];
  };
}
