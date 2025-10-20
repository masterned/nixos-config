{ ... }:
{
  services.syncthing = {
    enable = true;
    dataDir = "/home/spencer";
    openDefaultPorts = true;
    configDir = "/home/spencer/.config/syncthing";
    user = "spencer";
    group = "users";
    guiAddress = "0.0.0.0:8384";

    settings = {
      folders = {
        "cygnus_public" = {
          path = "/home/spencer/Public";
        };
      };
    };
  };
}
