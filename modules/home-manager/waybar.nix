{ pkgs, ... }:

{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;

        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [
          "mpd"
          "clock"
        ];
        modules-right = [
          "network"
          "backlight"
          "wireplumber"
          "battery"
          "custom/power"
        ];

        backlight = {
          "format" = "{percent}% {icon}";
          "format-icons" = [
            ""
            ""
          ];
        };

        battery = {
          "interval" = 60;
          "states" = {
            "warning" = 30;
            "critical" = 15;
          };
          "format" = "{capacity}% {icon}";
          "format-icons" = [
            ""
            ""
            ""
            ""
            ""
          ];
          "max-length" = 25;
        };

        clock = {
          interval = 1;
          format = "{:%Y-%m-%d %H:%M:%S}";
        };

        "custom/power" = {
          "format" = " ⏻ ";
          tooltip = false;
          "on-click" = "${pkgs.wlogout}/bin/wlogout -p layer-shell";
        };

        network = {
          "format-wifi" = "{essid} ({signalStrength}%) ";
          "format-ethernet" = "{ipadder}/{cidr} ";
        };

        wireplumber = {
          format = "{volume}% {icon}";
          "format-muted" = "";
          "on-click" = "${pkgs.pavucontrol}/bin/pavucontrol";
          "format-icons" = [
            ""
            ""
            ""
          ];
        };
      };
    };
  };
}
