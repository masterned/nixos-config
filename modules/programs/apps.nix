{
  flake.modules.homeManager.apps = { pkgs, ... }: {
    dconf = {
      enable = true;
      settings = {
        "org/gnome/desktop/interface" = {
          gtk-enable-primary-paste = true;
        };
      };
    };

    home.packages = with pkgs; [
      discord
      gimp3
      gnome-calculator
      gnome-characters
      gnome-font-viewer
      matcha
      nautilus
      onlyoffice-desktopeditors
      seahorse
      signal-desktop
      simple-scan
    ];

    programs = {
      imv.enable = true;
      zathura.enable = true;
    };

    services = {
      remmina.enable = true;
    };

    xdg = {
      enable = true;

      mimeApps = {
        enable = true;
        associations.added = {
          "application/pdf" = [ "org.pwmt.zathura.desktop" ];
          "image/jpeg" = [ "imv.desktop" ];
          "image/png" = [ "imv.desktop" ];
        };
        defaultApplications = {
          "application/pdf" = [ "org.pwmt.zathura.desktop" ];
          "image/jpeg" = [ "imv.desktop" ];
          "image/png" = [ "imv.desktop" ];
        };
      };

      userDirs = {
        enable = true;
        setSessionVariables = true;
      };
    };
  };
}
