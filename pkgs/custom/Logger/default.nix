{ pkgs ? import <nixpkgs> {} }:

let
  stdenv = pkgs.stdenv;
  dynamic-linker = pkgs.stdenv.cc.bintools.dynamicLinker;

  appName = "open-log-viewer";
  description = "open-log-viewer";
  desktopItem = pkgs.makeDesktopItem {
    name = appName;
    exec = appName;
    icon = appName;
    comment = description;
    desktopName = "Open log viewer";
    categories = "Office";
  };

in stdenv.mkDerivation rec {
    name = appName;

    src = pkgs.fetchurl {
      url = "https://github.com/tmoreno/open-log-viewer/releases/download/1.0.0/open-log-viewer_1.0.0.deb";
      sha256 = "118ml54jvipfcwjsp2glzj33wrp1bqmc91msf6vsbpp67hfl4iqc";
    };

    icon = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/tmoreno/open-log-viewer/master/docs/img/logo.png";
      sha256 = "1r7gci157fc3a4pzbv0rvlbamhpam4m7381m38i602sk11qcpbyz";
    };

    phases = "unpackPhase fixupPhase";

    buildInputs = with pkgs; [ wrapGAppsHook ];

    unpackPhase = ''
      "${pkgs.dpkg}/bin/dpkg" -x $src unpacked
      mkdir -p $out/
      cp -r unpacked/* $out/

      mkdir -p $out/share/{applications,icons/hicolor/scalable/apps}
      ln -s $icon $out/share/icons/hicolor/scalable/apps/open-log-viewer.png
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
    homepage = https://github.com/tmoreno/open-log-viewer;
    license = licenses.agpl3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ shitikovkirill ];
  };
}
