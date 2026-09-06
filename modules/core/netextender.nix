{ inputs, ... }:
{
  flake.modules.nixos.netextender = {
    imports = [ inputs.netextender.nixosModules.default ];

    services.netextender.enable = true;
  };
}
