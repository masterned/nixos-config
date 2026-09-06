{
  flake.modules = {
    nixos.desktop = { pkgs, ... }: {
      environment.systemPackages = [ pkgs.xwayland-satellite ];

      fonts.packages = with pkgs; [
        (google-fonts.override { fonts = [ "Genos" ]; })
        material-symbols
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
      ];

      hardware.graphics.enable = true;

      programs.niri.enable = true;

      services = {
        fwupd.enable = true;
        gnome.gnome-keyring.enable = true;
        gvfs.enable = true;
        udisks2.enable = true;
      };

      xdg.portal = {
        enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal
          xdg-desktop-portal-gtk
        ];
      };
    };

    homeManager.desktop = {
      services = {
        udiskie = {
          enable = true;
          automount = true;
          notify = true;
        };
      };

      xsession.preferStatusNotifierItems = true;
    };
  };
}
