{ inputs, pkgs, ... }:
{
  programs = {
    hyprland = {
      enable = true;
      withUWSM = true;

      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage =
        inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    hyprlock.enable = true;

    nm-applet.enable = true;

    waybar.enable = true;
  };

  security.pam.services.hyprlock = { };

  services = {
    hypridle.enable = true;
    playerctld.enable = true;
  };

  systemd.user.services = {
    # hyprsunset = {
    #   description = "Run hyprsunset check every hour";
    #   script = "/home/spencer/Workspaces/nixos/scripts/sunsetter.sh";
    #   serviceConfig = {
    #     Restart = "always";
    #     RuntimeMaxSec = 3600;
    #     Type = "simple";
    #   };
    #   wantedBy = [ "default.target" ];
    # };
  };

  environment.systemPackages = with pkgs; [
    brightnessctl
    grimblast
    hyprpaper
    hyprpicker
    hyprsunset
    hyprpolkitagent
    libnotify
    networkmanagerapplet
    pavucontrol
    slurp
    swaynotificationcenter
    wlogout
    wl-screenrec
  ];

  xdg.portal = {
    enable = true;

    extraPortals = with pkgs; lib.mkForce [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };
}
