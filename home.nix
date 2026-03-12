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
    outputs.hmModules.programs.imv
    outputs.hmModules.programs.jujutsu
    outputs.hmModules.programs.mpv
    outputs.hmModules.programs.newsboat
    outputs.hmModules.programs.nushell
    outputs.hmModules.programs.onlyoffice
    outputs.hmModules.programs.rmpc
    outputs.hmModules.programs.youtube-tui
    outputs.hmModules.programs.yt-dlp
    outputs.hmModules.programs.zathura
    outputs.hmModules.programs.zen-browser
    outputs.hmModules.services.mpd
    outputs.hmModules.xdg
  ];

  nixpkgs.config.allowUnfree = true;

  accounts.email.accounts = {
    "mr.spencerdent" = {
      enable = true;
      address = "mr.spencerdent@gmail.com";
      flavor = "gmail.com";
      imap = {
        authentication = "xoauth2";
        host = "imap.gmail.com";
        port = 993;
        tls = {
          enable = true;
          useStartTls = false;
        };
      };
      primary = true;
      realName = "Spencer Dent";
      signature = {
        showSignature = "append";
        text = ''
          --
          For Christ, for family, for mankind.
        '';
      };
      smtp = {
        authentication = "xoauth2";
        host = "smtp.gmail.com";
        port = 465;
        tls = {
          enable = true;
          useStartTls = false;
        };
      };
      thunderbird = {
        enable = true;
      };
    };
  };

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
      ouch
      rustup
      signal-desktop
      thunderbird
      typst
      vulnix
    ];
    file = { };
    shell.enableNushellIntegration = true;
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
    obs-studio.enable = true;
    ripgrep.enable = true;
    starship.enable = true;
    tealdeer.enable = true;
    yazi = {
      enable = true;
      enableNushellIntegration = true;
      shellWrapperName = "yy";
    };
    zoxide.enable = true;
  };

  services = {
    gpg-agent.enable = true;
    playerctld.enable = true;
    remmina.enable = true;
  };
}
