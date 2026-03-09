{ ... }:
{
  programs.imv = {
    enable = true;
  };

  xdg.mimeApps = {
    associations.added = {
      "image/jpeg" = [ "imv.desktop" ];
      "image/png" = [ "imv.desktop" ];
    };
    defaultApplications = {
      "image/jpeg" = [ "imv.desktop" ];
      "image/png" = [ "imv.desktop" ];
    };
  };
}
