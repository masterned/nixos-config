{
  outputs,
  pkgs,
  ...
}:

{
  imports = [
    outputs.hmModules.gnome-software
    outputs.hmModules.hypr
    outputs.hmModules.programs.atuin
    outputs.hmModules.programs.ashell
    outputs.hmModules.programs.bottom
    outputs.hmModules.programs.helix
    outputs.hmModules.programs.jujutsu
    outputs.hmModules.programs.mpv
    outputs.hmModules.programs.newsboat
    outputs.hmModules.programs.nushell
    outputs.hmModules.programs.onlyoffice
    outputs.hmModules.programs.rmpc
    outputs.hmModules.programs.yt-dlp
    outputs.hmModules.programs.zen-browser
    outputs.hmModules.services.mpd
  ];

  nixpkgs.config.allowUnfree = true;

  home = {
    username = "spencer";
    homeDirectory = "/home/spencer";
    stateVersion = "24.11"; # No touchy.
    packages = with pkgs; [
      discord
      ffmpeg
      gimp3
      inkscape
      libnotify
      networkmanagerapplet
      pavucontrol
      rustup
      signal-desktop
      thunderbird
      typst
    ];
    file = { };
    shell.enableNushellIntegration = true;
  };

  dconf = {
    enable = true;
    settings = { };
  };

  programs = {
    home-manager.enable = true;

    bacon.enable = true;
    bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        core
      ];
    };
    carapace = {
      enable = true;
      enableNushellIntegration = true;
    };
    direnv = {
      enable = true;
      enableNushellIntegration = true;
      nix-direnv.enable = true;
    };
    fzf.enable = true;
    ghostty = {
      enable = true;
      installBatSyntax = true;
    };
    imv.enable = true;
    obs-studio.enable = true;
    ripgrep.enable = true;
    starship.enable = true;
    tealdeer.enable = true;
    yazi = {
      enable = true;
      enableNushellIntegration = true;
    };
    zathura.enable = true;
    zoxide.enable = true;
  };

  services = {
    gpg-agent.enable = true;
    playerctld.enable = true;
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
    userDirs.enable = true;
  };
}
