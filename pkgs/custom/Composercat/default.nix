
{ pkgs ? import <nixpkgs> {} }:

let
  stdenv = pkgs.stdenv;
  dpkg = pkgs.dpkg;
  dynamic-linker = pkgs.stdenv.cc.bintools.dynamicLinker;

in pkgs.stdenv.mkDerivation rec {
  name = "composercat";
  src = pkgs.fetchurl {
    url = "http://downloads.getcomposercat.com/composercat/composercat_0.4.0_amd64.deb";
    sha256 = "1qvqvms6g2rwmll90zidv9dh0m0xvmhjzvgsv2yhh1k33bpdfayx";
  };

  phases = "unpackPhase fixupPhase";

  targetPath = "$out";

  unpackPhase = ''
    mkdir -p ${targetPath}
    ${dpkg}/bin/dpkg -x $src ${targetPath}
  '';
  
  packages = with pkgs; [
    at-spi2-atk gtk2
  ];

  libPathNative = with pkgs; lib.makeLibraryPath packages;
  libPath64 = with pkgs; lib.makeSearchPathOutput "lib" "lib64" packages;
  libPath = "${libPathNative}:${libPath64}";

  rpath = with pkgs; lib.concatStringsSep ":" [
    atomEnv.libPath
    targetPath
    "${targetPath}/opt/Composercat/"
    libPath
  ];

  fixupPhase = ''
    echo ${rpath}
    ls ${targetPath}/opt/Composercat
    
    patchelf \
    --set-interpreter "${dynamic-linker}" \
    --set-rpath "${rpath}" \
    ${targetPath}/opt/Composercat/composercat
    
    mkdir -p $out/bin
    ln -s ${targetPath}/opt/Composercat/composercat $out/bin/composercat
  '';
}
