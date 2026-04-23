{ pkgs, ... }:
let
  yt-urls-csv = ./youtube-urls.csv;
  csv-to-yt-json-nu = ./csv-to-yt-json.nu;
  yt-urls-json = pkgs.runCommand "csv-to-yt-json" { buildInputs = with pkgs; [ nushell ]; } ''
    nu ${csv-to-yt-json-nu} ${yt-urls-csv} > $out
  '';
  yt-urls = builtins.fromJSON (builtins.readFile yt-urls-json);
in
{
  programs.newsboat = {
    enable = true;

    extraConfig = /* config */ ''
      macro v set browser "mpv %u" ; open-in-browser ; set browser "${pkgs.xdg-utils}/bin/xdg-open"

      cleanup-on-quit yes

      # unbind keys
      unbind-key ENTER
      unbind-key j
      unbind-key k
      unbind-key J
      unbind-key K

      # bind keys - vim inspired
      bind-key j down
      bind-key k up
      bind-key l open
      bind-key h quit
    '';

    urls = yt-urls;
  };
}
