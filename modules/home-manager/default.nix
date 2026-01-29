{
  gnome-software = import ./gnome-software.nix;
  hypr = import ./hypr/default.nix;
  programs = import ./programs;
  services = import ./services;
  xdg = import ./xdg.nix;
}
