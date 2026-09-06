{ inputs, ... }:
let
  defaultSopsFile = ../../secrets/secrets.yaml;
  defaultSopsFormat = "yaml";
in
{
  flake.modules = {
    homeManager.secrets = { config, ... }: {
      imports = [ inputs.sops-nix.homeManagerModules.sops ];

      sops = {
        inherit defaultSopsFile defaultSopsFormat;

        age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
      };
    };

    nixos.secrets = { config, ... }: {
      imports = [ inputs.sops-nix.nixosModules.sops ];

      sops = {
        inherit defaultSopsFile defaultSopsFormat;

        # This really needs to be a system-level age file...
        age.keyFile = "/home/spencer/.config/sops/age/keys.txt";

        secrets = {
          "wifi/mobulidae_psk" = { };
          "wifi/petrosiidae_psk" = { };
          "wifi/afiusa-private_psk" = { };
          "wifi/afiusa-secure_psk" = { };
        };

        templates = {
          "network-manager.env".content = ''
            MOBULIDAE_PSK=${config.sops.placeholder."wifi/mobulidae_psk"}
            PETROSIIDAE_PSK=${config.sops.placeholder."wifi/petrosiidae_psk"}
            AFIUSA_PRIVATE_PSK=${config.sops.placeholder."wifi/afiusa-private_psk"}
            AFIUSA_SECURE_PSK=${config.sops.placeholder."wifi/afiusa-secure_psk"}
          '';
        };
      };
    };
  };
}
