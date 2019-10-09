
{ pkgs ? import <nixpkgs> {} }:

let
  stdenv = pkgs.stdenv;
  dpkg = pkgs.dpkg;

  appName = "vagga-${version}";
  version = "0.8.1";
  description = "Vagga";
in stdenv.mkDerivation rec {
  name = appName;
  builder = ./builder.sh;

  src = pkgs.fetchurl {
    url = "https://files.zerogw.com/vagga/vagga-${version}.tar.xz";
    sha256 = "010s0xdgdv9w1x87pkh1qsyzfykiz59z2inrzqkdw8ixayh7la7z";
  };

  meta = with stdenv.lib; {
    inherit description;
    homepage = https://vagga.readthedocs.io/en/latest/index.html;
    license = licenses.agpl3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ shitikovkirill ];
  };
}
