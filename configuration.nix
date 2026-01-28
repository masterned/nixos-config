{
  pkgs,
  inputs,
  outputs,
  config,
  system,
  ...
}:

{
  imports = [
    inputs.home-manager.nixosModules.default
    outputs.hosts.cygnus
  ];
  programs.nh = {
    enable = true;
    flake = "/home/spencer/Workspaces/nixos";
    clean = {
      enable = true;
      extraArgs = "--keep 5 --keep-since 3d";
    };
  };
  services.gnome = {
    gcr-ssh-agent.enable = false;
    gnome-keyring.enable = true;
  };
  home-manager = {
    extraSpecialArgs = {
      inherit inputs outputs system;
    };
    users.spencer = import ./home.nix;
  };
  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://hyprland.cachix.org"
      ];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };
  };
  nixpkgs.config.allowUnfree = true;
  environment = {
    systemPackages = with pkgs; [
      fd
      gcc
      git
      helix
      imv
      jujutsu
      mpv
      nixfmt
      nushell
      starship
      tealdeer
      vulnix
      yazi
    ];
    variables.EDITOR = "hx";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  systemd.services.mpd.environment.XDG_RUNTIME_DIR =
    "/run/user/${toString config.users.users.spencer.uid}";
}
