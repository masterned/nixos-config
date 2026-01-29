{ pkgs, ... }:
{
  programs.mpv = {
    enable = true;
    package = pkgs.mpv.override {
      scripts = with pkgs.mpvScripts; [
        mpris
        mpv-discord
        skipsilence
      ];
    };
    config = {
      ytdl-format = "bestvideo[height<=?720]+bestaudio";
      vo = "gpu";
      hwdec = "auto-copy-safe";
      hwdec-codecs = "all";
    };
  };
}
