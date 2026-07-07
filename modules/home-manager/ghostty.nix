{ ... }: {
  flake.homeModules.ghostty = { ... }: {
    programs.ghostty = {
      enable = true;
      installBatSyntax = true;
    };
  };
}
