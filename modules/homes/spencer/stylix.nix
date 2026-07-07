{ inputs, ... }: {
  flake.homeModules.stylix-spencer = { pkgs, ... }: {
    imports = [ inputs.stylix.homeModules.stylix ];

    stylix = {
      enable = true;

      # A more nix idiomatic way of storing the image. Could lead to chicken-and-egg if stored on same machine.
      image = pkgs.fetchurl {
        url = "http://cygnus.home.arpa/neo_EPCOT.jpg";
        sha256 = "sha256-XO9mAGBTR2gpzKASPxNEZF3BHuoZ//b4ZIKwBvPKlsA=";
      };

      base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";

      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Original-Ice";
        size = 24;
      };

      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.fira-code;
          name = "FiraCode Nerd Font Mono";
        };
        sansSerif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Sans";
        };
        serif = {
          package = pkgs.dejavu_fonts;
          name = "DejaVu Serif";
        };
        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
        sizes = {
          applications = 12;
          terminal = 12;
          desktop = 10;
          popups = 10;
        };
      };

      opacity = {
        applications = 1.0;
        terminal = 0.95;
        desktop = 0.9;
        popups = 0.95;
      };

      polarity = "dark";
    };
  };
}
