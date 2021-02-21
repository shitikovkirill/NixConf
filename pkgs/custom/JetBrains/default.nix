with import <nixpkgs> { };

let
  appName = "JetBrainsResetTrail";
  description = "Reset IDE";

  reset = name:
    writeShellScriptBin "reset-${name}" ''
      echo "Removing evaluation key for ${name}"
      rm -rf ~/.config/JetBrains/${name}*/eval
      rm -rf ~/.java/.userPrefs/jetbrains/${lib.strings.toLower name}

      echo "Resetting evalsprt in options.xml for ${name}"
      sed -i '/evlsprt/d' ~/.config/JetBrains/${name}*/options/other.xml

      echo "Resetting evalsprt in prefs.xml"
      sed -i '/evlsprt/d' ~/.java/.userPrefs/prefs.xml

      echo "Change date file for ${name}"
      find ~/.config/JetBrains/${name}* -type d -exec touch -t $(date +"%Y%m%d%H%M") {} +;
      find ~/.config/JetBrains/${name}* -type f -exec touch -t $(date +"%Y%m%d%H%M") {} +;

      ${cowsay}/bin/cowsay "Done"
    '';

in mkShell rec {
  name = appName;

  buildInputs = [
    (reset "WebStorm")
    (reset "DataGrip")
    (reset "PyCharm")
    (reset "RubyMine")
    (reset "PhpStorm")
    (reset "GoLand")
    cowsay
  ];

  meta = with lib; {
    inherit description;
    license = licenses.agpl3;
    platforms = platforms.linux;
    maintainers = with maintainers; [ shitikovkirill ];
  };
}
