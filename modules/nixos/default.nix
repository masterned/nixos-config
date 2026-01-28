{
  hypr = import ./hypr.nix;
  podman = import ./podman.nix;
  programs = import ./programs/default.nix;
  services = import ./services/default.nix;
  stylix = import ./stylix.nix;
}
