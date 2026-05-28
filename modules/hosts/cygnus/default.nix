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

        home-manager = {
          backupFileExtension = "backup";
          extraSpecialArgs = {
            inherit inputs;
            outputs = self;
            system = pkgs.stdenv.hostPlatform.system;
          };
          users.spencer = import ../../_homes/spencer;
        };

        imports = [
          inputs.nixos-hardware.nixosModules.framework-13-7040-amd
          self.nixosModules.common
          self.nixosModules.cygnusHardware
          self.nixosModules.nh
          self.nixosModules.niri
          self.nixosModules.noctalia
          self.nixosModules.podman
          self.nixosModules.printing
          self.nixosModules.stylix
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

              Host ambroxan
                Hostname 192.168.12.178
                Port 22
                User afi-spencerd

                IdentitiesOnly yes
                IdentityFile ~/.ssh/ambroxan
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
              "wheel"
            ];
            useDefaultShell = true;
          };
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
