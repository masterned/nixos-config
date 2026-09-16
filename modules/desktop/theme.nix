{ inputs, ... }:
let
  commonSettings =
    { lib, pkgs }:
    {
      enable = true;

      base16Scheme = "${pkgs.base16-schemes}/share/themes/nord.yaml";

      cursor = {
        package = lib.mkDefault pkgs.bibata-cursors;
        name = lib.mkDefault "Bibata-Original-Ice";
        size = lib.mkDefault 24;
      };

      fonts = {
        monospace = {
          package = lib.mkDefault pkgs.nerd-fonts.fira-code;
          name = lib.mkDefault "FiraCode Nerd Font Mono";
        };
        sansSerif = {
          package = lib.mkDefault pkgs.dejavu_fonts;
          name = lib.mkDefault "DejaVu Sans";
        };
        serif = {
          package = lib.mkDefault pkgs.dejavu_fonts;
          name = lib.mkDefault "DejaVu Serif";
        };
        emoji = {
          package = lib.mkDefault pkgs.noto-fonts-color-emoji;
          name = lib.mkDefault "Noto Color Emoji";
        };
        sizes = {
          applications = lib.mkDefault 12;
          terminal = lib.mkDefault 12;
          desktop = lib.mkDefault 10;
          popups = lib.mkDefault 10;
        };
      };

      image = lib.mkDefault ../../assets/images/neo_EPCOT.jpg;

      opacity = {
        applications = lib.mkDefault 1.0;
        terminal = lib.mkDefault 0.95;
        desktop = lib.mkDefault 0.9;
        popups = lib.mkDefault 0.95;
      };

      polarity = lib.mkDefault "dark";
    };
in
{
  flake.modules = {
    homeManager.theme = { lib, pkgs, ... }: {
      imports = [ inputs.stylix.homeModules.stylix ];

      stylix = commonSettings { inherit lib pkgs; } // {

        targets = {
          qt = {
            enable = true;
            platform = lib.mkDefault "qtct";
          };
          zen-browser.enable = false;
        };
      };

      fonts.fontconfig.enable = true;

      home.pointerCursor.enable = true;
    };

    nixos.theme = { lib, pkgs, ... }: {
      imports = [ inputs.stylix.nixosModules.stylix ];

      stylix = commonSettings { inherit lib pkgs; };
    };
  };
}
