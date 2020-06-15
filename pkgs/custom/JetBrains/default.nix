with import <nixpkgs> { };

let
  appName = "reset_trail";
  description = "Reset IDE";

  reset = name:
    pkgs.writeShellScriptBin "reset-${name}" ''
      echo "Removing evaluation key for ${name}"
      rm -rf ~/.config/JetBrains/${name}*/config/eval
      rm -rf ~/.java/.userPrefs/jetbrains/${pkgs.lib.strings.toLower name}

      echo "Resetting evalsprt in options.xml for ${name}"
      sed -i '/evlsprt/d' ~/.${name}*/config/options/other.xml

      echo "Resetting evalsprt in prefs.xml"
      sed -i '/evlsprt/d' ~/.java/.userPrefs/prefs.xml

      echo "Change date file for ${name}"
      find ~/.config/JetBrains/${name}* -type d -exec touch -t $(date +"%Y%m%d%H%M") {} +;
      find ~/.config/JetBrains/${name}* -type f -exec touch -t $(date +"%Y%m%d%H%M") {} +;

      ${pkgs.cowsay}/bin/cowsay "Done"
    '';

in pkgs.stdenv.mkDerivation rec {
  name = appName;

  buildInputs = [
    (reset "WebStorm")
    (reset "DataGrip")
    (reset "PyCharm")
    (reset "RubyMine")
    (reset "PhpStorm")
    (reset "GoLand")
    pkgs.cowsay
  ];

  meta = with stdenv.lib; {
    inherit description;
    license = licenses.agpl3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ shitikovkirill ];
  };
}
