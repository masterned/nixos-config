{ ... }:
{
  flake.nixosModules.niri =
    { pkgs, ... }:
    {
      programs.niri.enable = true;
      xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal
          xdg-desktop-portal-gtk
          xdg-desktop-portal-gnome
        ];
      };
    };
}
