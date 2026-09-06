{ inputs, ... }:
{
  flake.modules = {
    homeManager.noctalia = { pkgs, ... }: {
      programs.noctalia = {
        enable = true;
        package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
        systemd.enable = true;
      };
    };

    nixos.noctalia =
      { pkgs, ... }:
      {
        environment.systemPackages = with pkgs; [
          gpu-screen-recorder
          fastfetch
        ];

        nix.settings = {
          extra-substituters = [ "https://noctalia.cachix.org" ];
          extra-trusted-public-keys = [
            "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
          ];
        };

        programs.noctalia = {
          enable = true;
          package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
          recommendedServices.enable = true;
          systemd.enable = true;
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
