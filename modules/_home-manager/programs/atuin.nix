{ ... }:
{
  programs.atuin = {
    enable = true;
    enableNushellIntegration = true;
    settings = {
      auto_sync = false;
      history_filter = [
        "^yy"
        "^jj (?:ci \-m '(?:f(?:eat|ix):.*'|wip')|diff|log|ci|st)$"
      ];
      update_check = false;
    };
  };
}
