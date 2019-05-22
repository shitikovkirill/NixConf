{ pkgs ? import <nixpkgs> {} }:

let
  stdenv = pkgs.stdenv;
  dynamic-linker = pkgs.stdenv.cc.bintools.dynamicLinker;
  description = "open-log-viewer";
  desktopItem = pkgs.makeDesktopItem {
    name = "open-log-viewer";
    exec = "open-log-viewer";
    icon = "open-log-viewer";
    comment = description;
    desktopName = "open-log-viewer";
    categories = "Develop";
  };

in stdenv.mkDerivation rec {
    name = "open-log-viewer";

    src = pkgs.fetchurl {
        url = "https://github.com/tmoreno/open-log-viewer/releases/download/1.0.0/open-log-viewer_1.0.0.deb";
        sha256 = "118ml54jvipfcwjsp2glzj33wrp1bqmc91msf6vsbpp67hfl4iqc";
    };

    phases = "unpackPhase fixupPhase";

    buildInputs = with pkgs; [ wrapGAppsHook ];
    
    unpackPhase = ''
        "${pkgs.dpkg}/bin/dpkg" -x $src unpacked
        mkdir -p $out/
        cp -r unpacked/* $out/
    '';

    
  packages = with pkgs; [
    at-spi2-atk
  ];

  libPathNative = with pkgs; lib.makeLibraryPath packages;
  libPath64 = with pkgs; lib.makeSearchPathOutput "lib" "lib64" packages;
  libPath = "${libPathNative}:${libPath64}";

  rpath = with pkgs; lib.concatStringsSep ":" [
    atomEnv.libPath
    "$out/opt/open-log-viewer/"
    libPath
  ];

  fixupPhase = ''
    echo ${rpath}
    ls $out/opt/open-log-viewer/open-log-viewer
    
    patchelf \
    --set-interpreter "${dynamic-linker}" \
    --set-rpath "${rpath}" \
    $out/opt/open-log-viewer/open-log-viewer
    
    mkdir -p $out/bin
    ln -s $out/opt/open-log-viewer/open-log-viewer $out/bin/open-log-viewer
  '';

  meta = with stdenv.lib; {
    inherit description;
    homepage = https://github.com/uglide/RedisDesktopManager;
    license = licenses.agpl3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ emmanuelrosa dtzWill ];
  };
} 
