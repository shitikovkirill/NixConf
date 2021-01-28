{ pkgs ? import <nixpkgs> { } }:

let
  stdenv = pkgs.stdenv;
  dpkg = pkgs.dpkg;
  dynamic-linker = pkgs.stdenv.cc.bintools.dynamicLinker;

  description = "Free cross-platform password manager compatible with KeePass ";

in pkgs.stdenv.mkDerivation rec {
  name = "keeweb";

  src = pkgs.fetchurl {
    url =
      "https://github.com/keeweb/keeweb/releases/download/v1.14.2/KeeWeb-1.14.2.linux.x64.deb";
    sha256 = "1806yg1p3ppf59nyw2z7vc7xm227smi11s3gsqmfwbyn9x9zksxh";
  };

  phases = "unpackPhase fixupPhase";

  targetPath = "$out";

  unpackPhase = ''
    mkdir -p ${targetPath}
    ${dpkg}/bin/dpkg --fsys-tarfile $src | tar xf -
    rm usr/bin/*
    cp -r usr/* ${targetPath}
  '';

  packages = with pkgs; [ at-spi2-atk utillinux ];

  libPathNative = with pkgs; lib.makeLibraryPath packages;
  libPath64 = with pkgs; lib.makeSearchPathOutput "lib" "lib64" packages;
  libPath = "${libPathNative}:${libPath64}";

  rpath = with pkgs;
    lib.concatStringsSep ":" [
      "${mesa}/lib/"
      "${libdrm}/lib/"
      "${libxkbcommon}/lib/"
      "${atomEnv.libPath}"
      "${targetPath}/share/keeweb-desktop/"
      libPath
    ];

  fixupPhase = ''
    patchelf \
    --set-interpreter "${dynamic-linker}" \
    --set-rpath "${rpath}" \
    ${targetPath}/share/keeweb-desktop/keeweb

    echo ${rpath}

     ln -s ${targetPath}/share/keeweb-desktop/keeweb $out/bin/keeweb
  '';

  meta = with stdenv.lib; {
    inherit description;
    homepage = "https://keeweb.info";
    license = licenses.mit;
    maintainers = with maintainers; [ shitikovkirill ];
    platforms = platforms.x86_64;
  };
}
