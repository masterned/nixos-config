{ inputs, ... }: {
  flake = {
    homeModules.noctalia = {
      imports = [
        inputs.noctalia.homeModules.default
      ];

      programs.noctalia = {
        enable = true;
        systemd.enable = true;
      };
    };

    nixosModules.noctalia =
      { pkgs, ... }:
      {
        environment.systemPackages = [
          inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
          pkgs.gpu-screen-recorder
          pkgs.fastfetch
        ];

        nix.settings = {
          extra-substituters = [ "https://noctalia.cachix.org" ];
          extra-trusted-public-keys = [
            "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
          ];
        };

        services.displayManager.noctalia-greeter = {
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
      };
  };
}
