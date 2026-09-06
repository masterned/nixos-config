{
  flake.modules.homeManager.rio = {
    programs.rio = {
      enable = true;
      settings = {
        copy-on-select = true;
        navigation.hide-if-single = true;
        title.content = "";
      };
    };
  };
}
