{ config, inputs, ... }:
let
  user = "spencer";
in
{
  flake = {
    homeConfigurations."${user}@cygnus" = inputs.home-manager.lib.homeManagerConfiguration {
      extraSpecialArgs = { inherit inputs; };

      modules =
        (with config.flake.modules.homeManager; [
          apps
          bluetooth
          desktop
          ghostty
          helix
          herdr
          jujutsu
          media
          newsboat
          niri
          noctalia
          podman
          rio
          rmpc
          secrets
          shell
          ssh
          theme
          thunderbird
          zen-browser
        ])
        ++ [
          ./_home.nix
          ./_theme.nix
          ./_zen-browser.nix
        ];

      pkgs = import inputs.nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    };

    modules.nixos."users/${user}" = { config, ... }: {
      programs.nh = {
        enable = true;
        flake = "/home/${user}/Projects/nixos";
      };

      services.openssh.settings.AllowUsers = [ user ];

      sops.secrets."users/${user}_pw_hash".neededForUsers = true;

      users.users.${user} = {
        isNormalUser = true;
        description = "Spencer Dent";
        extraGroups = [
          "networkmanager"
          "podman"
          "wheel"
          "lp"
          "scanner"
        ];
        hashedPasswordFile = config.sops.secrets."users/${user}_pw_hash".path;
        useDefaultShell = true;
      };
    };
  };
}
