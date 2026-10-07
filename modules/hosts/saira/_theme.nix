{ pkgs, ... }:
{
  stylix = {
    enable = true;

    base16Scheme = "${pkgs.base16-schemes}/share/themes/everforest.yaml";

    fonts.sansSerif = {
      package = pkgs.dejavu_fonts;
      name = "DejaVu Sans";
    };

    image = ../../../assets/images/sairas_bungalow_5_1.jpg;
  };
}
