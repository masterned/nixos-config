{
  config,
  inputs,
  lib,
  outputs,
  pkgs,
  system,
  ...
}:
let
  hostName = "cygnus";
in
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
    outputs.nixosModules.programs.noctalia
    outputs.nixosModules.services.printing
    outputs.nixosModules.stylix
  ];

  networking = {
    inherit hostName;
  };

  programs = {
    nh.flake = "/home/spencer/Workspaces/nixos";
    ssh = {
      extraConfig = ''
        Host diakonos
          Hostname 10.0.0.2
          Port 22
          User cygnus

          IdentitiesOnly yes
          IdentityFile ~/.ssh/diakonos
      '';
    };
  };

  services = {
    blueman.enable = true;
    caddy = {
      enable = true;
      openFirewall = true;
      virtualHosts =
        let
          host_tld = "${hostName}.local";
          http_root = "/srv/http";
          md_book = name: {
            "${name}.${host_tld}" = {
              extraConfig = ''
                root * ${http_root}/${name}
                file_server
              '';
            };
          };
        in
        {
          ":80" = {
            extraConfig = ''
              root * ${http_root}
              file_server
            '';
          };
        }
        // md_book "grimoire"
        // md_book "rockhopper";
    };
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
