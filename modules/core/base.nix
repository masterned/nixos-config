{ inputs, ... }: {
  flake.modules.nixos.base = { pkgs, ... }: {
    environment = {
      systemPackages = with pkgs; [
        age
        git
        helix
        jujutsu
        sops
      ];

      shells = [
        "${pkgs.nushell}/bin/nu"
        "/run/current-system/sw/bin/nu"
      ];

      variables.EDITOR = "hx";
    };

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

    nix = {
      settings = {
        auto-optimise-store = true;
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        nix-path = [ "nixpkgs=${inputs.nixpkgs}" ];
      };
    };

    nixpkgs.config.allowUnfree = true;

    programs.nushell.enable = true;

    users.defaultUserShell = pkgs.nushell;
  };
}
