{
  inputs,
  lib,
  outputs,
  pkgs,
  ...
}:
{
  boot.initrd = {
    luks.devices."luks-b9ce3219-26fc-4eca-ba70-d402e918a306".device =
      "/dev/disk/by-uuid/b9ce3219-26fc-4eca-ba70-d402e918a306";
  };
  hardware = {
    bluetooth.enable = true;
    graphics.enable = true;
  };
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.framework-13-7040-amd
    outputs.hosts.common
    outputs.nixosModules.podman
    outputs.nixosModules.services.printing
    outputs.nixosModules.stylix
  ];
  networking.hostName = "cygnus";
  services = {
    blueman.enable = true;
    tlp.enable = lib.mkForce false;
    tuned.enable = true;
  };
  users = {
    defaultUserShell = pkgs.nushell;
    users.spencer = {
      isNormalUser = true;
      description = "Spencer Dent";
      extraGroups = [
        "networkmanager"
        "podman"
        "seat"
        "wheel"
      ];
      useDefaultShell = true;
    };
  };
}
