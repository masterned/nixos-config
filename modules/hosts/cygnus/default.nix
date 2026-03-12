{
  config,
  inputs,
  lib,
  outputs,
  pkgs,
  system,
  ...
}:
{
  boot.initrd = {
    luks.devices."luks-b9ce3219-26fc-4eca-ba70-d402e918a306".device =
      "/dev/disk/by-uuid/b9ce3219-26fc-4eca-ba70-d402e918a306";
  };

  hardware = {
    bluetooth.enable = true;
    graphics.enable = true;
    logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };
  };

  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = {
      inherit inputs outputs system;
    };
    users.spencer = import ../../../home.nix;
  };

  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
    outputs.hostModules.common
    outputs.nixosModules.podman
    outputs.nixosModules.programs.nh
    outputs.nixosModules.services.printing
    outputs.nixosModules.stylix
  ];

  networking.hostName = "cygnus";

  programs.nh.flake = "/home/spencer/Workspaces/nixos";

  services = {
    blueman.enable = true;
    flatpak.enable = true;
    gnome = {
      gcr-ssh-agent.enable = false;
      gnome-keyring.enable = true;
    };
    tlp.enable = lib.mkForce false;
    tuned.enable = true;
  };

  users = {
    defaultUserShell = pkgs.nushell;
    users.spencer = {
      isNormalUser = true;
      description = "Spencer Dent";
      extraGroups = [
        "networkmanager"
        "podman"
        "seat"
        "wheel"
      ];
      useDefaultShell = true;
    };
  };

  systemd.services.mpd.environment.XDG_RUNTIME_DIR =
    "/run/user/${toString config.users.users.spencer.uid}";
}
