{
  flake.modules = {
    homeManager.niri = {
      xdg.configFile."niri/config.kdl".source = ./config.kdl;
    };
    nixos.niri = { pkgs, ... }: {
      environment.systemPackages = [ pkgs.xwayland-satellite ];

      programs.niri.enable = true;
    };
  };
}
