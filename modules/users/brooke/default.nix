{ config, inputs, ... }:
let
  user = "brooke";
  osConfig = config;
in
{
  flake.modules.nixos."users/${user}" = { config, pkgs, ... }: {
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    home-manager = {
      extraSpecialArgs = { inherit pkgs; };

      useGlobalPkgs = true;
      useUserPackages = true;

      users.${user} = {
        imports =
          (with osConfig.flake.modules.homeManager; [
            apps
            bluetooth
            ghostty
            helix
            jujutsu
            media
            newsboat
            rmpc
            shell
            zen-browser
          ])
          ++ [
            ./_zen-browser.nix
          ];

        fonts.fontconfig.enable = true;

        home = {
          homeDirectory = "/home/brooke";
          pointerCursor.enable = true;
          stateVersion = "25.05";
          username = "brooke";
        };

        programs = {
          home-manager.enable = true;

          jujutsu.settings.user = {
            email = "brookephillips55@gmail.com";
            name = "Brooke Dent";
          };
        };

        stylix.targets = {
          rofi.enable = false;
          zen-browser.enable = false;
        };
      };
    };

    nix.settings.trusted-users = [ user ];

    # will need this for impermanence
    sops.secrets."users/${user}_pw_hash".neededForUsers = true;

    users.users.${user} = {
      isNormalUser = true;
      description = "Brooke Dent";
      extraGroups = [
        "networkmanager"
        "wheel"
        "lp"
        "scanner"
      ];
      hashedPasswordFile = config.sops.secrets."users/${user}_pw_hash".path;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHimMNpccwfw+uuLOJtbGiMe/qaD6lgk2e/U+5MwTQAM brookephillips55@gmail.com"
      ];
      shell = pkgs.nushell;
    };
  };
}
