{ config, pkgs, ... }:

let
  myOverride = self: super: {
    python38 = super.python38.override {
      packageOverrides = package-self: package-super:
        let
          cookiecutter = package-super.cookiecutter.overrideAttrs
            (oldAttrs: rec {
              version = "1.7.0";
              src = package-super.fetchPypi {
                pname = oldAttrs.pname;
                inherit version;
                sha256 = "1bh4vf45q9nanmgwnw7m0gxirndih9yyz5s0y2xbnlbcqbhrg6a7";
              };
            });
        in with package-super; {
          setuptools-scm-git-archive =
            super.callPackage ./modules/setuptools-scm-git-archive.nix {
              inherit buildPythonPackage fetchPypi;
              pythonPackages = package-super;

            };
          create-aio-app = super.callPackage ./modules/create-aio-app.nix {
            inherit buildPythonPackage fetchPypi;
            pythonPackages = package-self;
            cookiecutter = cookiecutter;
          };
        };
    };
  };
in {
  nixpkgs.overlays = [ myOverride ];

  environment.systemPackages = with pkgs; [
    python3
    winpdb
    python38Packages.create-aio-app
  ];

  programs.zsh = { ohMyZsh = { plugins = [ "python" "django" ]; }; };

  environment.shellAliases = { py-clean = ''find -name "*.pyc" -delete''; };
}
