{ inputs, pkgs, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;
  hyprpkgs = inputs.hyprland.packages;
in
{
  environment.variables.NIXOS_OZONE_WL = "1";

  programs.hyprland = {
    enable = true;
    withUWSM = true;

    package = hyprpkgs.${system}.hyprland;
    portalPackage = hyprpkgs.${system}.xdg-desktop-portal-hyprland;
  };

  security.pam.services.hyprlock = { };

  xdg.portal = {
    enable = true;

    extraPortals =
      with pkgs;
      lib.mkForce [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
      ];
  };
}
