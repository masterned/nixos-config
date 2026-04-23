{
  # ashell = import ./programs/ashell.nix;
  atuin = import ./programs/atuin.nix;
  bottom = import ./programs/bottom.nix;
  gnome-software = import ./gnome-software.nix;
  helix = import ./programs/helix.nix;
  hypr = import ./hypr/default.nix;
  imv = import ./programs/imv.nix;
  jujutsu = import ./programs/jujutsu.nix;
  mpd = import ./services/mpd.nix;
  mpv = import ./programs/mpv.nix;
  newsboat = import ./programs/newsboat;
  nushell = import ./programs/nushell.nix;
  onlyoffice = import ./programs/onlyoffice.nix;
  programs = import ./programs;
  rmpc = import ./programs/rmpc.nix;
  services = import ./services;
  waybar = import ./programs/waybar.nix;
  xdg = import ./xdg.nix;
  youtube-tui = import ./programs/youtube-tui.nix;
  yt-dlp = import ./programs/yt-dlp.nix;
  zathura = import ./programs/zathura.nix;
  zen-browser = import ./programs/zen-browser.nix;
}
