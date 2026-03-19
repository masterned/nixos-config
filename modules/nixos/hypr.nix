{ pkgs, ... }:
{
  environment.variables.NIXOS_OZONE_WL = "1";

  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  security.pam.services.hyprlock = { };

  services.udisks2.enable = true;

  xdg.portal = {
    enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };
}
