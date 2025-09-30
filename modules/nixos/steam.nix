{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
      protonup
  ];

  programs = {
    gamemode.enable = true;

    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
  };
}
