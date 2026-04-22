{
  nh = import ./programs/nh.nix;
  hypr = import ./hypr.nix;
  ly = import ./services/ly.nix;
  noctalia = import ./programs/noctalia.nix;
  pipewire = import ./services/pipewire.nix;
  podman = import ./podman.nix;
  printing = import ./services/printing.nix;
  regreet = import ./programs/regreet.nix;
  steam = import ./programs/steam.nix;
  stylix = import ./stylix.nix;
  syncthing = import ./services/syncthing.nix;
}
