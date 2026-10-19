{
  flake.modules.nixos.afi-wifi = { config, lib, ... }: {
    networking.networkmanager.ensureProfiles = {
      environmentFiles = [ config.sops.templates."afi-wifi.env".path ];
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
        (lib.genAttrs [
          "AFIUSA-Guest"
        ] mkWifi)
        // lib.genAttrs [
          "AFIUSA-Private"
          "AFIUSA-Secure"
        ] mkWifiStableMAC;
    };

    sops = {
      secrets =
        lib.genAttrs
          [
            "wifi/afiusa-guest_psk"
            "wifi/afiusa-private_psk"
            "wifi/afiusa-secure_psk"
          ]
          (_: {
            sopsFile = ../../secrets/afi.yaml;
          });
      templates."afi-wifi.env".content = ''
        AFIUSA_GUEST_PSK=${config.sops.placeholder."wifi/afiusa-guest_psk"}
        AFIUSA_PRIVATE_PSK=${config.sops.placeholder."wifi/afiusa-private_psk"}
        AFIUSA_SECURE_PSK=${config.sops.placeholder."wifi/afiusa-secure_psk"}
      '';
    };
  };
}
