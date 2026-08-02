{ ... }: {
  flake.nixosModules.networking =
    { config, lib, ... }:
    let
      hostName = "cygnus";
    in
    {
      networking = {
        inherit hostName;

        extraHosts = ''
          127.0.0.1 cygnus.home.arpa grimoire.cygnus.home.arpa rockhopper.cygnus.home.arpa
        '';

        nameservers = [
          "9.9.9.9"
          "149.112.112.112"
        ];

        networkmanager = {
          ensureProfiles = {
            environmentFiles = [ config.sops.templates."network-manager.env".path ];
            profiles =
              let
                normal_wifi = ssid: {
                  connection = {
                    id = ssid;
                    type = "wifi";
                    interface-name = "wlp1s0";
                  };
                  wifi = {
                    mode = "infrastructure";
                    inherit ssid;
                  };
                  wifi-security = {
                    auth-alg = "open";
                    key-mgmt = "wpa-psk";
                    psk = (lib.toUpper "\$${ssid}_PSK");
                  };
                  ipv4 = {
                    method = "auto";
                  };
                  ipv6 = {
                    addr-gen-mode = "default";
                    method = "auto";
                  };
                  proxy = { };
                };
                stable_ssid_wifi = ssid: (normal_wifi ssid) // { wifi.cloned-mac-address = "stable-ssid"; };
              in
              {
                Mobulidae = stable_ssid_wifi "Mobulidae";
                Petrosiidae = stable_ssid_wifi "Petrosiidae";
                AFIUSA-Private = stable_ssid_wifi "AFIUSA-Private";
              };
          };
        };
      };

      services.resolved = {
        enable = true;

        settings.Resolve = {
          DNSOverTLS = true;
          DNSSEC = true;
          Domains = [ "~." ];
          FallbackDNS = [
            "9.9.9.9"
            "149.112.112.112"
          ];
        };
      };
    };
}
