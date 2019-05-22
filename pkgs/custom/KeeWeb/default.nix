
{ pkgs ? import <nixpkgs> {} }:

let
  stdenv = pkgs.stdenv;
  dpkg = pkgs.dpkg;
  dynamic-linker = pkgs.stdenv.cc.bintools.dynamicLinker;

in pkgs.stdenv.mkDerivation rec {
  name = "keeweb";
  src = pkgs.fetchurl {
    url = "https://github.com/keeweb/keeweb/releases/download/v1.8.2/KeeWeb-1.8.2.linux.x64.deb";
    sha256 = "17frvq4hzybxpczpjv93m1fvs0q0wxprw30kvwps5zhrxf8wmp3y";
  };

  phases = "unpackPhase fixupPhase";

  targetPath = "$out";

  unpackPhase = ''
    mkdir -p ${targetPath}
    ${dpkg}/bin/dpkg -x $src ${targetPath}
  '';
  
  packages = with pkgs; [
    at-spi2-atk utillinux
  ];

  libPathNative = with pkgs; lib.makeLibraryPath packages;
  libPath64 = with pkgs; lib.makeSearchPathOutput "lib" "lib64" packages;
  libPath = "${libPathNative}:${libPath64}";

  rpath = with pkgs; lib.concatStringsSep ":" [
    atomEnv.libPath
    "${targetPath}/opt/keeweb-desktop/"
    libPath
  ];

  fixupPhase = ''
    echo ${rpath}
    ls ${targetPath}/opt/keeweb-desktop/ -la
    
    patchelf \
    --set-interpreter "${dynamic-linker}" \
    --set-rpath "${rpath}" \
    ${targetPath}/opt/keeweb-desktop/KeeWeb
    
    mkdir -p $out/bin
    ln -s ${targetPath}/opt/keeweb-desktop/KeeWeb $out/bin/keeweb
  '';
}
