{
  pkgs,
  inputs,
  outputs,
  config,
  ...
}:

{
  imports = [
    inputs.home-manager.nixosModules.default
    outputs.hosts.cygnus
  ];

  services.gnome = {
    gcr-ssh-agent.enable = false;
    gnome-keyring.enable = true;
  };

  nix = {
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    settings = {
      auto-optimise-store = true;
    };
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

  services.flatpak.enable = true;

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
