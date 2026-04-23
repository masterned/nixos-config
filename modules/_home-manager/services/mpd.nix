{ ... }:
{
  services = {
    mpd = {
      enable = true;
      extraConfig = # config
        ''
          audio_output {
            type "pipewire"
            name "PipeWire Sound Server"
          }

          audio_output {
            type "fifo"
            name "mpd_fifo"
            path "/tmp/mpd.fifo"
            format "44100:16:2"
          }

          auto_update "yes"

          bind_to_address "/tmp/mpd_socket"
        '';
    };
    mpd-discord-rpc.enable = true;
    mpd-mpris.enable = true;
  };
}
