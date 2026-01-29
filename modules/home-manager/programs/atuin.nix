{ ... }:
{
  programs.atuin = {
    enable = true;
    enableNushellIntegration = true;
    settings = {
      auto_sync = false;
      update_check = false;
    };
  };
}
