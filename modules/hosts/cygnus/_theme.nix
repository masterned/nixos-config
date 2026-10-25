{ pkgs, ... }: {
  stylix.fonts.sansSerif = {
    package = pkgs.atkinson-hyperlegible;
    name = "Atkinson Hyperlegible";
  };
}
