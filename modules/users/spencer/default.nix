{
  config,
  inputs,
  ...
}:
{
  flake = {
    homeConfigurations."spencer@cygnus" = inputs.home-manager.lib.homeManagerConfiguration {
      extraSpecialArgs = { inherit inputs; };

      modules =
        (with config.flake.modules.homeManager; [
          apps
          bluetooth
          desktop
          ghostty
          helix
          jujutsu
          media
          newsboat
          noctalia
          podman
          rio
          rmpc
          secrets
          shell
          theme
          thunderbird
          zen-browser
        ])
        ++ [
          ./_home.nix
          ./_zen-browser.nix
        ];

      pkgs = import inputs.nixpkgs {
        system = "x86_64-linux";
        config.allowUnfree = true;
      };
    };

    modules.nixos."users/spencer" = {
      programs.nh = {
        enable = true;
        flake = "/home/spencer/Projects/nixos";
      };

      services.openssh.settings.AllowUsers = [ "spencer" ];

      users.users.spencer = {
        isNormalUser = true;
        description = "Spencer Dent";
        extraGroups = [
          "networkmanager"
          "podman"
          "wheel"
          "lp"
          "scanner"
        ];
        useDefaultShell = true;
      };
    };
  };
}
