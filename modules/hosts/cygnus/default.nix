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
          logitech.wireless.enable = true;
        };

        imports = [
          inputs.nixos-hardware.nixosModules.framework-13-7040-amd
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
          self.nixosModules.secrets-cygnus
          self.nixosModules.user-spencer
        ];

        programs = {
          dconf.enable = true;

          nh.flake = "/home/spencer/Workspaces/nixos";

          solaar.enable = true;

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

          displayManager.noctalia-greeter = {
            enable = true;
            cursorTheme = {
              name = "Bibata-Original-Ice";
              package = pkgs.bibata-cursors;
            };
            settings = {
              appearance = {
                hide_logo = true;
              };
            };
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
