{ config, inputs, ... }:
{
  flake = {
    modules.nixos."hosts/cygnus" =
      let
        hostName = "cygnus";
      in
      {
        imports =
          (with config.flake.modules.nixos; [
            audio
            base
            bluetooth
            boot
            desktop
            media
            netextender
            networking
            nh
            noctalia
            podman
            printing
            secrets
            theme
          ])
          ++ [
            config.flake.modules.nixos."users/spencer"
            ./_hardware.nix
            inputs.nixos-hardware.nixosModules.framework-13-7040-amd
          ];

        boot.initrd.luks.devices."luks-b9ce3219-26fc-4eca-ba70-d402e918a306".device =
          "/dev/disk/by-uuid/b9ce3219-26fc-4eca-ba70-d402e918a306";

        hardware = {
          graphics.enable = true;
          keyboard.zsa.enable = true;
          logitech.wireless.enable = true;
        };

        networking = {
          hostName = "cygnus";

          extraHosts = ''
            127.0.0.1 cygnus.home.arpa grimoire.cygnus.home.arpa rockhopper.cygnus.home.arpa
          '';
        };

        programs = {
          solaar.enable = true;
        };

        services = {
          caddy =
            let
              localdomain = "${hostName}.home.arpa";
            in
            {
              enable = true;
              openFirewall = true;
              virtualHosts =
                let
                  http_root = "/srv/http";
                  md_book = name: {
                    "${name}.${localdomain}" = {
                      extraConfig = ''
                        root * ${http_root}/${name}
                        file_server
                      '';
                    };
                  };
                in
                {
                  "${localdomain}:80, ${localdomain}:443" = {
                    extraConfig = ''
                      root * ${http_root}/public
                      file_server browse
                    '';
                  };
                }
                // md_book "grimoire"
                // md_book "rockhopper";
            };

          flatpak.enable = true;
        };

        system.stateVersion = "23.05"; # No touchy!

        time.timeZone = "America/New_York";
      };

    nixosConfigurations.cygnus = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
      };

      modules = [ config.flake.modules.nixos."hosts/cygnus" ];
    };
  };
}
