{ inputs, ... }:
{
  flake.nixosModules.netextender = {
    imports = [ inputs.netextender.nixosModules.default ];
    services.netextender.enable = true;
  };
}
