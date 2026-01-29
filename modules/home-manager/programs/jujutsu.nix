{ ... }:
{
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        email = "mr.spencerdent@gmail.com";
        name = "Spencer Dent";
      };
      ui = {
        default-command = "log";
        pager = ":builtin";
        diff-editor = ":builtin";
      };
    };
  };
}
