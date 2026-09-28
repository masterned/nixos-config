{ inputs, ... }:
{
  flake.modules.nixos.netextender = {
    imports = [ inputs.netextender.nixosModules.default ];

    services = {
      netextender = {
        enable = true;
        splitDns = {
          enable = true;
          domains = [
            "afi-usa.com"
            "aromaticfragrances.com"
          ];
        };
      };
      resolved.enable = true;
    };
  };
}
