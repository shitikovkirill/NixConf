{ config, pkgs, ... }:

let
runStreamScript = pkgs.writeShellScriptBin "run-stream-script"
  ''
    DEFAULT_OUTPUT=$(pacmd list-sinks | grep -A1 '* index' | grep -oP '<\K[^ >]+')
    pactl load-module module-combine-sink \
      sink_name=record-n-play \
      slaves=$DEFAULT_OUTPUT \
      sink_properties=device.description='Record-and-Play'
    pactl move-sink-input record-n-play
    echo 'Running strim...'
    parec --format=s16le -d record-n-play.monitor | \
      lame -r --quiet -q 3 --lowpass 17 --abr 192 - 'temp.mp3'
  '';
in {
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  environment.systemPackages = with pkgs; [
    pavucontrol lame
  ];

  environment.shellAliases = {
    run-stream = "${runStreamScript}/bin/run-stream-script";
  };
}
