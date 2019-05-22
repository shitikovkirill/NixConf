
{ pkgs ? import <nixpkgs> {} }:

let
  stdenv = pkgs.stdenv;
  dpkg = pkgs.dpkg;
  dynamic-linker = pkgs.stdenv.cc.bintools.dynamicLinker;

in pkgs.stdenv.mkDerivation rec {
  name = "stacker";
  src = pkgs.fetchurl {
    url = "https://github.com/lopidio/stacker/releases/download/v0.1.0/stacker_0.1.0_amd64.deb";
    sha256 = "1277kvgnal7f4vml8z7kv8wfhf2zj4sva4n3sbhg708r6aq5rlxa";
  };

  phases = "unpackPhase fixupPhase";

  targetPath = "$out";

  unpackPhase = ''
    mkdir -p ${targetPath}
    ${dpkg}/bin/dpkg -x $src ${targetPath}
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
    echo ${rpath}
    ls ${targetPath}/opt/stacker/stacker
    
        patchelf \
        --set-interpreter "${dynamic-linker}" \
        --set-rpath "${rpath}" \
        ${targetPath}/opt/stacker/stacker
    
    mkdir -p $out/bin
    ln -s ${targetPath}/opt/stacker/stacker $out/bin/stacker
  '';
}
