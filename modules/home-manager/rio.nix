{ ... }: {
  flake.homeModules.rio = { ... }: {
    programs.rio = {
      enable = true;
      settings = {
        copy-on-select = true;
      };
    };
  };
}
