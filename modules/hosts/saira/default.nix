{ config, inputs, ... }:
let
  hostName = "saira";
in
{
  flake = {
    modules.nixos."hosts/${hostName}" = {
      imports =
        (with config.flake.modules.nixos; [
          audio
          base
          bluetooth
          boot
          desktop
          media
          nh
          niri
          noctalia
          printing
          secrets
          ssh
          theme
        ])
        ++ [
          config.flake.modules.nixos."users/brooke"
          ./_hardware.nix
          ./_theme.nix
        ];

      boot = {
        initrd.luks.devices."luks-0e4653f0-da64-4103-9f03-16def0dea92b".device =
          "/dev/disk/by-uuid/0e4653f0-da64-4103-9f03-16def0dea92b";
        loader.systemd-boot = {
          enable = true;
          configurationLimit = 10;
        };
      };

      networking = {
        inherit hostName;
        networkmanager = {
          enable = true;
          insertNameservers = [
            "9.9.9.9" # Quad9
            "1.1.1.1" # Cloudflare
          ];
          wifi.macAddress = "stable-ssid";
        };
      };

      security.sudo.extraConfig = ''
        Defaults pwfeedback
      '';

      services.flatpak.enable = true;

      system.stateVersion = "25.05"; # No touchy!

      time.timeZone = "America/New_York";

      xdg.portal.config.common.default = "*";
    };

    nixosConfigurations."${hostName}" = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
      };

      modules = [ config.flake.modules.nixos."hosts/${hostName}" ];
    };
  };
}
