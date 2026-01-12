{
  pkgs,
  inputs,
  outputs,
  config,
  lib,
  system,
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
    kernelPackages = pkgs.linuxPackages_latest;

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
    hostName = "cygnus";

    networkmanager = {
      enable = true;

      insertNameservers = [
        "9.9.9.9" # Quad9
        "1.1.1.1" # Cloudflare
      ];
    };
  };

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

    ssh = {
      startAgent = true;
    };
  };

  services = {
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

    pipewire = {
      enable = true;

      alsa.enable = true;
      alsa.support32Bit = true;

      pulse.enable = true;

      wireplumber.enable = true;
    };

    printing = {
      enable = true;
      drivers = with pkgs; [
        gutenprint
        hplip
      ];
    };

    pulseaudio.enable = false;

    seatd.enable = true;

    tlp.enable = lib.mkForce false;

    tuned.enable = true;
  };

  security.rtkit.enable = true;

  users = {
    defaultUserShell = pkgs.nushell;

    users.spencer = {
      isNormalUser = true;
      description = "Spencer Dent";
      extraGroups = [
        "networkmanager"
        "seat"
        "wheel"
      ];
      useDefaultShell = true;
    };
  };

  home-manager = {
    extraSpecialArgs = {
      inherit inputs outputs system;
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

  nixpkgs.config.allowUnfree = true;

  environment = {
    systemPackages = with pkgs; [
      gcc
      git
      helix
      imv
      jujutsu
      nixfmt
      nushell
      mpv
      starship
      tealdeer
      vulnix
      yazi
    ];

    variables = {
      EDITOR = "hx";
    };
  };

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
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
