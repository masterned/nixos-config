{ inputs, self, ... }:
{
  flake = {
    nixosConfigurations.cygnus = inputs.nixpkgs.lib.nixosSystem {
      modules = [ self.nixosModules.cygnus ];
    };

    nixosModules.cygnus =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      let
        hostName = "cygnus";
      in
      {
        boot = {
          initrd = {
            luks.devices."luks-b9ce3219-26fc-4eca-ba70-d402e918a306".device =
              "/dev/disk/by-uuid/b9ce3219-26fc-4eca-ba70-d402e918a306";
          };
        };

        environment.systemPackages = [ pkgs.xwayland-satellite ];

        fonts.packages = [
          (pkgs.google-fonts.override { fonts = [ "Genos" ]; })
        ];

        hardware = {
          bluetooth.enable = true;
          graphics.enable = true;
          logitech.wireless = {
            enable = true;
            enableGraphical = true;
          };
        };

        imports = [
          inputs.nixos-hardware.nixosModules.framework-13-7040-amd
          inputs.sops-nix.nixosModules.sops
          self.nixosModules.caddy
          self.nixosModules.common
          self.nixosModules.cygnusHardware
          self.nixosModules.networking
          self.nixosModules.nh
          self.nixosModules.niri
          self.nixosModules.noctalia
          self.nixosModules.podman
          self.nixosModules.printing
          self.nixosModules.stylix
          self.nixosModules.user-spencer
        ];

        programs = {
          dconf.enable = true;
          nh.flake = "/home/spencer/Workspaces/nixos";
          ssh = {
            extraConfig = ''
              Host diakonos
                Hostname 10.0.0.2
                Port 22
                User cygnus

                IdentitiesOnly yes
                IdentityFile ~/.ssh/diakonos

              Host ambroxan
                Hostname 192.168.12.58
                Port 22
                User afi-spencerd

                IdentitiesOnly yes
                IdentityFile ~/.ssh/ambroxan
            '';
          };
        };

        services = {
          blueman.enable = true;

          displayManager.cosmic-greeter.enable = true;
          flatpak.enable = true;
          gnome = {
            gcr-ssh-agent.enable = false;
            gnome-keyring.enable = true;
          };

          resolved = {
            enable = true;
            settings.Resolve = {
              DNSOverTLS = true;
              DNSSEC = true;
              Domains = [ "~." ];
              FallbackDNS = [
                "9.9.9.9"
                "149.112.112.112"
              ];
            };
          };

          tlp.enable = lib.mkForce false;
          tuned.enable = true;
        };

        users = {
          defaultUserShell = pkgs.nushell;
        };

        sops = {
          age.keyFile = "/home/spencer/.config/sops/age/keys.txt";
          defaultSopsFile = ../../../secrets/secrets.yaml;
          defaultSopsFormat = "yaml";

          secrets = {
            "wifi/mobulidae_psk" = { };
            "wifi/petrosiidae_psk" = { };
          };

          templates."network-manager.env".content = ''
            MOBULIDAE_PSK=${config.sops.placeholder."wifi/mobulidae_psk"}
            PETROSIIDAE_PSK=${config.sops.placeholder."wifi/petrosiidae_psk"}
          '';
        };

        system.stateVersion = "23.05"; # No touchy!

        systemd.services = {
          mpd.environment.XDG_RUNTIME_DIR = "/run/user/${toString config.users.users.spencer.uid}";
          nixos-upgrade.environment =
            let
              name = "NixOS Auto-upgrade";
              email = "root@&lt;${hostName}&gt;";
            in
            {
              GIT_AUTHOR_NAME = name;
              GIT_AUTHOR_EMAIL = email;
              GIT_COMMITTER_NAME = name;
              GIT_COMMITTER_EMAIL = email;
            };
        };

        xdg.portal = {
          enable = true;
          extraPortals = with pkgs; [ xdg-desktop-portal ];
        };
      };
  };
}
