{ config, inputs, ... }:
let
  user = "brooke";
in
{
  flake = {
    modules.nixos."users/${user}" = { pkgs, ... }: {
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      home-manager = {
        extraSpecialArgs = { inherit pkgs; };

        useGlobalPkgs = true;
        useUserPackages = true;

        users.${user} = {
          imports =
            (with config.flake.modules.homeManager; [
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
              ./_home.nix
              ./_zen-browser.nix
            ];
        };
      };

      nix.settings.trusted-users = [ user ];

      # will need this for impermanence
      # sops.secrets."users/${user}_pw_hash".neededForUsers = true;

      users.users.${user} = {
        isNormalUser = true;
        description = "Brooke Dent";
        extraGroups = [
          "networkmanager"
          "wheel"
          "lp"
          "scanner"
        ];
        # hashedPasswordFile = sops.secrets."users/${user}_pw_hash".path;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHimMNpccwfw+uuLOJtbGiMe/qaD6lgk2e/U+5MwTQAM brookephillips55@gmail.com"
        ];
        shell = pkgs.nushell;
      };
    };
  };
}
