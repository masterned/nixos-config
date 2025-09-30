# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  pkgs,
  inputs,
  outputs,
  config,
  lib,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    outputs.nixosModules.hypr
    outputs.nixosModules.regreet
    outputs.nixosModules.steam
    outputs.nixosModules.stylix
    outputs.nixosModules.syncthing
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

    nh = {
      enable = true;

      flake = "/home/spencer/Workspaces/nixos";

      clean = {
        enable = true;

        extraArgs = "--keep 5 --keep-since 3d";
      };
    };

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # mtr.enable = true;
    # gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    ssh = {
      startAgent = true;
    };
  };

  # List services that you want to enable:
  services = {
    # auto-cpufreq.enable = true;

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    blueman.enable = true;

    fwupd.enable = true;

    gnome = {
      gcr-ssh-agent.enable = false;
      gnome-keyring.enable = true;
    };

    gvfs.enable = true;

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    pipewire = {
      enable = true;

      alsa.enable = true;
      alsa.support32Bit = true;

      pulse.enable = true;

      wireplumber.enable = true;
    };

    power-profiles-daemon.enable = lib.mkForce false;

    # Enable CUPS to print documents.
    printing.enable = true;

    pulseaudio.enable = false;

    seatd.enable = true;

    tlp.enable = lib.mkForce false;

    tuned.enable = true;
  };

  security.rtkit.enable = true;

  system = {
    # autoUpgrade = {
    #   enable = true;
    # };
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    defaultUserShell = pkgs.nushell;

    users.spencer = {
      isNormalUser = true;
      description = "Spencer Dent";
      extraGroups = [
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
      bottom
      dust
      gcc
      git
      helix
      imv
      jujutsu
      nixfmt-rfc-style
      nushell
      mpv
      mprocs
      starship
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

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  systemd.services = {
    mpd.environment = {
      XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.spencer.uid}";
    };
  };
}
