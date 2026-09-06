{
  flake.modules.homeManager.jujutsu = {
    programs.jujutsu = {
      enable = true;

      settings = {
        ui = {
          default-command = "log";
          pager = ":builtin";
          diff-editor = ":builtin";
        };
      };
    };
  };
}
