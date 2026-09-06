{
  flake.modules.homeManager.thunderbird = {
    programs.thunderbird = {
      enable = true;

      policies.DisableTelemetry = true;

      profiles.default.isDefault = true;

      settings = {
        "mail.shell.checkDefaultClient" = false;
        "mailnews.oauth.useExternalBrowser" = true;
        "mailnews.start_page.enabled" = false;
      };
    };
  };
}
