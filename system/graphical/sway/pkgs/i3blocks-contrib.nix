{ pkgs ? import <nixpkgs> { } }:
with pkgs;
stdenv.mkDerivation rec {
  pname = "i3blocks-contrib";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "vivien";
    repo = pname;
    rev = "f80389bf76dac31f634636751e6f0ae3ee6caf38";
    sha256 = "1da0wkwj9s3gigr8ndcp7m680s3nngnx42rfsij4db1nj3ypvp72";
  };

  pathDocker = stdenv.lib.makeSearchPath "bin" ([ docker ]);
  pathWifi = stdenv.lib.makeSearchPath "bin" ([ iw ]);
  pathAcpi = stdenv.lib.makeSearchPath "bin" ([ acpi ]);
  pathKey = stdenv.lib.makeSearchPath "bin" ([ xorg.setxkbmap gawk ]);

  nativeBuildInputs = [ makeWrapper ];
  buildInputs = [ bashInteractive ];
  installPhase = ''
    mkdir -p $out
    cp . $out -r
  '';
  dontBuild = true;

  postInstall = ''
    wrapProgram "$out/docker/docker" --prefix PATH : $pathDocker
    wrapProgram "$out/wifi/wifi" --prefix PATH : $pathWifi
    wrapProgram "$out/battery/battery" --prefix PATH : $pathAcpi
    wrapProgram "$out/key_layout/key_layout" --prefix PATH : $pathKey
  '';

  meta = with stdenv.lib; {
    description = "Fucking Fast File-Manager";
    homepage = "https://github.com/dylanaraps/fff";
    license = licenses.mit;
    maintainers = [ maintainers.tadeokondrak ];
    platforms = platforms.all;
  };
}
