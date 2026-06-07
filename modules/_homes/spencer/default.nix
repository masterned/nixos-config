{
  outputs,
  pkgs,
  ...
}:

{
  imports = [
    outputs.homeModules.gnome-software
    outputs.homeModules.atuin
    outputs.homeModules.bottom
    outputs.homeModules.helix
    outputs.homeModules.imv
    outputs.homeModules.jujutsu
    outputs.homeModules.mpv
    outputs.homeModules.newsboat
    outputs.homeModules.nushell
    outputs.homeModules.onlyoffice
    outputs.homeModules.rmpc
    outputs.homeModules.youtube-tui
    outputs.homeModules.yt-dlp
    outputs.homeModules.zathura
    outputs.homeModules.zen-browser
    outputs.homeModules.mpd
    outputs.homeModules.xdg
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

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        gtk-enable-primary-paste = true;
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
      networkmanagerapplet
      ouch
      rustup
      signal-desktop
      tagutil
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
