{ inputs, pkgs, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;
in
{
  programs =
    let
      packages = inputs.hyprland.packages;
    in
    {
      hyprland = {
        enable = true;
        withUWSM = true;

        package = packages.${system}.hyprland;
        portalPackage = packages.${system}.xdg-desktop-portal-hyprland;
      };
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
