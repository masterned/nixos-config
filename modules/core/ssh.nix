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
        enableDefaultConfig = lib.mkDefault false;
        settings = {
          "*" = {
            AddKeysToAgent = lib.mkDefault "yes";
            Compression = lib.mkDefault "no";
            ControlMaster = lib.mkDefault "auto";
            ControlPath = lib.mkDefault "~/.ssh/control-%C";
            ControlPersist = lib.mkDefault "10m";
            ForwardAgent = lib.mkDefault "no";
            ForwardX11 = lib.mkDefault "no";
            HashKnownHosts = lib.mkDefault "yes";
            ServerAliveInterval = lib.mkDefault 60;
            StrictHostKeyChecking = lib.mkDefault "ask";
            UpdateHostKeys = lib.mkDefault "yes";
          };
        };
      };
    };
  };
}
