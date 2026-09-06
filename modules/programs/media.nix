{
  flake.modules = {
    nixos.media = {
      services.playerctld.enable = true;
    };

    homeManager.media = { pkgs, ... }: {
      home.packages = with pkgs; [
        ffmpeg
        tagutil
        youtube-tui
      ];

      programs = {
        mpv = {
          enable = true;
          package = pkgs.mpv.override {
            scripts = with pkgs.mpvScripts; [
              mpris
              mpv-discord
              skipsilence
            ];
          };
          bindings = {
            "-" = "add volume -5";
            "=" = "add volume 5";
          };
          config = {
            ytdl-format = "bestvideo[height<=?720]+bestaudio";
            vo = "gpu";
            hwdec = "auto-copy-safe";
            hwdec-codecs = "all";
            volume-max = 100;
          };
        };

        yt-dlp = {
          enable = true;
          settings = {
            embed-chapters = true;
            embed-subs = true;
            sub-langs = "en";
            embed-thumbnail = true;
          };
        };
      };
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
    };
  };
}
