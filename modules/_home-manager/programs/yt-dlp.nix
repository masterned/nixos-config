{ ... }:
{
  programs.yt-dlp = {
    enable = true;
    settings = {
      embed-chapters = true;
      embed-subs = true;
      sub-langs = "en";
      embed-thumbnail = true;
    };
  };
}
