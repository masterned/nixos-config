# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  pkgs,
  inputs,
  outputs,
  config,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    inputs.stylix.nixosModules.stylix
  ];

  boot = {
    loader = {
      # Bootloader.
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd = {
      luks.devices."luks-b9ce3219-26fc-4eca-ba70-d402e918a306".device =
        "/dev/disk/by-uuid/b9ce3219-26fc-4eca-ba70-d402e918a306";
      systemd.enable = true;
    };

    plymouth = {
      enable = true;
    };
  };

  networking = {
    hostName = "cygnus"; # Define your hostname.

    # firewall = {
    # Open ports in the firewall.
    # allowedTCPPorts = [ ... ];
    # allowedUDPPorts = [ ... ];

    # Or disable the firewall altogether.
    # enable = false;
    # };

    # Configure network proxy if necessary
    # proxy = {
    # default = "http://user:password@proxy:port/";
    # noProxy = "127.0.0.1,localhost,internal.domain";
    # };

    # Enable networking
    networkmanager.enable = true;

    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  hardware = {
    bluetooth = {
      enable = true;
    };
    graphics.enable = true;
    keyboard = {
      zsa.enable = true;
    };
  };

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };

  programs = {
    direnv = {
      enable = true;
    };

    hyprland = {
      enable = true;
      withUWSM = true;

      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
    hyprlock.enable = true;

    gamemode.enable = true;

    nh = {
      enable = true;

      flake = "/home/spencer/Workspaces/nixos";

      clean = {
        enable = true;

        extraArgs = "--keep 5 --keep-since 3d";
      };
    };

    nm-applet.enable = true;

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # mtr.enable = true;
    # gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    regreet = {
      enable = true;

      font = {
        name = "DejaVu Sans";
      };

      settings = {
        default_session = {
          command = "uwsm start hyprland-uwsm.desktop";
          user = "greeter";
        };

        gtk = {
          application_prefer_dark_theme = true;
        };

        commands = {
          reboot = [
            "systemctl"
            "reboot"
          ];
          poweroff = [
            "systemctl"
            "poweroff"
          ];
          x11_prefix = [
            "startx"
            "/usr/bin/env"
          ];
        };

        appearance = {
          greeting_msg = "Make sure to get some sleep!";
        };

        widget = {
          clock = {
            format = "%a %Y-%m-%d %H:%M:%S";
            resolution = "500ms";
            timezone = "America/NewYork";
            label_width = 150;
          };
        };
      };
    };

    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };

    waybar.enable = true;
  };

  # List services that you want to enable:
  services = {
    atd.enable = true;

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    blueman.enable = true;

    fwupd.enable = true;

    gnome.gnome-keyring.enable = true;

    gvfs.enable = true;

    hypridle.enable = true;

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    playerctld.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

      wireplumber.enable = true;

      # If you want to use JACK applications, uncomment this
      #jack.enable = true;

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      #media-session.enable = true;
    };

    # Enable CUPS to print documents.
    printing.enable = true;

    pulseaudio.enable = false;

    syncthing = {
      enable = true;
      dataDir = "/home/spencer";
      openDefaultPorts = true;
      configDir = "/home/spencer/.config/syncthing";
      user = "spencer";
      group = "users";
      guiAddress = "0.0.0.0:8384";

      settings = {
        folders = {
          "cygnus_public" = {
            path = "/home/spencer/Public";
          };
        };
      };
    };
  };

  security = {
    pam.services = {
      greetd = {
        enable = true;
        enableGnomeKeyring = true;
      };
      hyprlock = { };
    };
    rtkit.enable = true;
  };

  system = {
    autoUpgrade = {
      enable = true;
      dates = "weekly";
    };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.nushell;

    users.spencer = {
      isNormalUser = true;
      description = "Spencer Dent";
      extraGroups = [
        "atd"
        "networkmanager"
        "wheel"
        "input"
      ];
      useDefaultShell = true;
    };
  };

  home-manager = {
    extraSpecialArgs = {
      inherit inputs outputs;
    };
    users = {
      "spencer" = import ./home.nix;
    };
  };

  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];

    settings = {
      auto-optimise-store = true;

      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };

  # Allow unfree packages
  nixpkgs = {
    config.allowUnfree = true;

    overlays = with outputs.overlays; [
      modifications
      stable-packages
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    systemPackages = with pkgs; [
      at
      bottom
      brightnessctl
      dust
      gcc
      git
      gtypist
      helix
      hyprpaper
      hyprpicker
      hyprsome
      hyprsunset
      hyprsysteminfo
      hyprpolkitagent
      imv
      jujutsu
      libnotify
      networkmanagerapplet
      nixfmt-rfc-style
      nushell
      mpv
      pavucontrol
      starship
      swaynotificationcenter
      tealdeer
      vulnix
      yazi
      zen-browser
    ];

    variables = {
      EDITOR = "hx";
    };
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    material-symbols
  ];

  stylix = {
    enable = true;

    image = ./assets/images/neo_EPCOT.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";

    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Original-Ice";
      size = 24;
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.fira-code;
        name = "FiraCode Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 12;
        terminal = 12;
        desktop = 10;
        popups = 10;
      };
    };

    opacity = {
      applications = 1.0;
      terminal = 0.95;
      desktop = 1.0;
      popups = 0.95;
    };

    polarity = "dark";
  };

  xdg.portal = {
    enable = true;
    extraPortals =
      with pkgs;
      lib.mkForce [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-hyprland
        xdg-desktop-portal-gnome
      ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  systemd.services.mpd.environment = {
    XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.spencer.uid}";
  };
}
