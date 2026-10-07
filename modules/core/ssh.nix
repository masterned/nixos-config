{
  flake.modules = {
    nixos.ssh = { lib, ... }: {
      services.openssh = {
        enable = true;

        # explicitly open port 22 per machine per interface or network
        openFirewall = lib.mkDefault false;

        settings = {
          KbdInteractiveAuthentication = false;
          PasswordAuthentication = false;

          # supposedly nixos-anywhere needs to be able to override this
          PermitRootLogin = lib.mkDefault "no";

          X11Forwarding = false;
        };
      };
    };
    homeManager.ssh = { lib, ... }: {
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        settings = {
          "*" = {
            AddKeysToAgent = lib.mkDefault "yes";
            ForwardAgent = lib.mkDefault false;
            HashKnownHosts = lib.mkDefault true;
            ServerAliveInterval = lib.mkDefault 60;
          };
        };
      };
    };
  };
}
