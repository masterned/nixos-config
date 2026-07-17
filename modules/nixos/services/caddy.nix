{ ... }: {
  flake.nixosModules.caddy = { config, ... }: {
    services.caddy =
      let
        hostName = config.networking.hostName;
        localdomain = "${hostName}.home.arpa";
      in
      {
        enable = true;
        openFirewall = true;
        virtualHosts =
          let
            http_root = "/srv/http";
            md_book = name: {
              "${name}.${localdomain}" = {
                extraConfig = ''
                  root * ${http_root}/${name}
                  file_server
                '';
              };
            };
          in
          {
            "${localdomain}:80, ${localdomain}:443" = {
              extraConfig = ''
                root * ${http_root}/public
                file_server browse
              '';
            };
          }
          // md_book "grimoire"
          // md_book "rockhopper";
      };
  };
}
