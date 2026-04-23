{ inputs, self, ... }:
{
  flake.nixosModules.common =
    { pkgs, ... }:
    {
      boot = {
        initrd.systemd.enable = true;
        kernelPackages = pkgs.linuxPackages_latest;
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };
        plymouth.enable = true;
      };

      environment = {
        systemPackages = with pkgs; [
          fd
          gcc
          git
          helix
          jujutsu
          nushell
          starship
          tealdeer
          yazi
        ];
        variables.EDITOR = "hx";
      };

      fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        material-symbols
      ];

      hardware.keyboard.zsa.enable = true;

      imports = [
        inputs.home-manager.nixosModules.default
        self.nixosModules.hypr
        self.nixosModules.regreet
        # self.nixosModules.ly
        self.nixosModules.pipewire
      ];

      i18n = {
        defaultLocale = "en_US.UTF-8";
        extraLocaleSettings = {
          LC_ADDRESS = "en_US.UTF-8";
          LC_IDENTIFICATION = "en_US.UTF-8";
          LC_MEASUREMENT = "en_US.UTF-8";
          LC_MONETARY = "en_US.UTF-8";
          LC_NAME = "en_US.UTF-8";
          LC_NUMERIC = "en_US.UTF-8";
          LC_PAPER = "en_US.UTF-8";
          LC_TELEPHONE = "en_US.UTF-8";
          LC_TIME = "en_US.UTF-8";
        };
      };

      networking.networkmanager = {
        enable = true;
      };

      nix = {
        nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
        settings = {
          auto-optimise-store = true;
          experimental-features = [
            "nix-command"
            "flakes"
          ];
        };
      };

      nixpkgs.config.allowUnfree = true;

      programs.ssh.startAgent = true;

      services = {
        fwupd.enable = true;
        gvfs.enable = true;
        seatd.enable = true;
      };

      system.autoUpgrade = {
        enable = true;

        dates = "daily";
        flake = "/home/spencer/Workspaces/nixos";
        flags = [
          "--print-build-logs"
          "--commit-lock-file"
        ];
        randomizedDelaySec = "45min";
      };

      time.timeZone = "America/New_York";
    };
}
