{
  config,
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

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "24.11"; # Please read the comment before changing.

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
    configFile."uwsm/env".source =
      "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
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
