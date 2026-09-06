{
  flake.modules.homeManager.ssh = { lib, ... }: {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      settings = {
        "*" = {
          AddKeysToAgent = lib.mkDefault true;
          ForwardAgent = lib.mkDefault false;
          HashKnownHosts = lib.mkDefault true;
          ServerAliveInterval = lib.mkDefault 60;
        };
      };
    };
  };
}
