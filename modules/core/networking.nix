{
  flake.modules.nixos.networking =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      environment.systemPackages = [ pkgs.networkmanagerapplet ];

      networking = {
        nameservers = lib.mkDefault [
          "9.9.9.9"
          "149.112.112.112"
        ];

        networkmanager = {
          enable = true;

          ensureProfiles = {
            environmentFiles = [ config.sops.templates."network-manager.env".path ];
            profiles =
              let
                mkWifi = ssid: {
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
                    psk = "\$${lib.toUpper (builtins.replaceStrings [ "-" ] [ "_" ] ssid)}_PSK";
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
                mkWifiStableMAC =
                  ssid: lib.recursiveUpdate (mkWifi ssid) { wifi.cloned-mac-address = "stable-ssid"; };
              in
              lib.genAttrs [
                "Mobulidae"
                "Petrosiidae"
                "AFIUSA-Private"
                "AFIUSA-Secure"
              ] mkWifiStableMAC;
          };
        };
      };

      services = {
        resolved = {
          enable = true;
          settings.Resolve = {
            DNSOverTLS = false;
            DNSSEC = false;
            LLMNR = false;
            MulticastDNS = false;
            # Domains = [ "~." ];
            # FallbackDNS = [
            #   "9.9.9.9"
            #   "149.112.112.112"
            # ];
          };
        };
      };
    };
}
