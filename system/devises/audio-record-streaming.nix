{ config, pkgs, ... }:

let
runStreamScript = pkgs.writeShellScriptBin "run-stream-script"
  ''
    DEFAULT_OUTPUT=$(pacmd list-sinks | grep -A1 '* index' | grep -oP '<\K[^ >]+')
    # Check that record-n-play not loadad
    if ! pactl list | grep "record-n-play"; then
      echo "load-module record-n-play"
      pactl load-module module-combine-sink \
        sink_name=record-n-play \
        slaves=$DEFAULT_OUTPUT \
        sink_properties=device.description='Record-and-Play'
    fi
    pactl move-sink-input record-n-play
    echo 'Running strim...'
    parec --format=s16le -d record-n-play.monitor | \
      lame -r --quiet -q 3 --lowpass 17 --abr 192 - 'temp.mp3'
  '';
  # https://askubuntu.com/questions/60837/record-a-programs-output-with-pulseaudio/60856#60856
  # pactl list | grep -A 10 "record-n-play"
  # Delete by Owner Module: 24
  # pactl unload-module 24
in {
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  environment.systemPackages = with pkgs; [
    pavucontrol lame paprefs
  ];

  environment.shellAliases = {
    run-stream = "${runStreamScript}/bin/run-stream-script";
  };
}
