{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    protonup-ng
  ];

  programs = {
    gamemode.enable = true;

    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };
  };
}
