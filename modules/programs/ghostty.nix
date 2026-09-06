{
  flake.modules.homeManager.ghostty = {
    programs.ghostty = {
      enable = true;
      installBatSyntax = true;
    };
  };
}
