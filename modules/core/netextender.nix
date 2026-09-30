{ inputs, ... }:
{
  flake.modules.nixos.netextender = {
    imports = [ inputs.netextender.nixosModules.default ];

    services = {
      netextender = {
        enable = true;

        connections.afi = {
          domain = "afi-usa.com";
          port = 4433;
          server = "vpn.afi-usa.com";
        };

        defaultConnection = "afi";

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
