{ inputs, pkgs, system, ... }:
let
  hyprpkgs = inputs.hyprland.packages.${system};
in
{
  environment.variables.NIXOS_OZONE_WL = "1";

  nix.settings = {
    substituters = [
      "https://hyprland.cachix.org"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true;

    package = hyprpkgs.hyprland;
    portalPackage = hyprpkgs.xdg-desktop-portal-hyprland;
  };

  security.pam.services.hyprlock = { };

  services.udisks2.enable = true;

  xdg.portal = {
    enable = true;

    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      hyprpkgs.xdg-desktop-portal-hyprland
    ];
  };
}
