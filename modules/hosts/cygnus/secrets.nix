{ inputs, ... }: {
  flake.nixosModules.secrets-cygnus = { config, ... }: {
    imports = [ inputs.sops-nix.nixosModules.sops ];

    sops = {
      age.keyFile = "/home/spencer/.config/sops/age/keys.txt";

      defaultSopsFile = ../../../secrets/secrets.yaml;
      defaultSopsFormat = "yaml";

      secrets = {
        "wifi/mobulidae_psk" = { };
        "wifi/petrosiidae_psk" = { };
        "wifi/afiusa-private_psk" = { };
      };

      templates = {
        "network-manager.env".content = ''
          MOBULIDAE_PSK=${config.sops.placeholder."wifi/mobulidae_psk"}
          PETROSIIDAE_PSK=${config.sops.placeholder."wifi/petrosiidae_psk"}
          AFIUSA-PRIVATE_PSK=${config.sops.placeholder."wifi/afiusa-private_psk"}
        '';
      };
    };
  };
}
