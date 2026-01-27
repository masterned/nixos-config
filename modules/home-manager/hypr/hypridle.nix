{ inputs, pkgs, ... }:
{
  services = {
    hypridle = {
      enable = true;
      package = inputs.hypridle.packages.${pkgs.stdenv.hostPlatform.system}.hypridle;

      settings = {
        general = {
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
          lock_cmd = "pidof hyprlock || hyprlock";
          ignore_dbus_inhibit = false;
          ignore_systemd_inhibit = false;
        };

        listener = [
          # Turn down screen brightness after 1.5mins
          {
            timeout = 90;
            on-timeout = "brightnessctl -s set 0";
            on-resume = "brightnessctl -r";
          }
          # Turn off screen after 5mins
          {
            timeout = 300;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
          # Lock settion after 5.5mins
          {
            timeout = 330;
            on-timeout = "loginctl lock-session";
          }
          # Suspend PC after 30mins
          {
            timeout = 1800;
            on-timeout = "systemctl suspend";
          }
        ];
      };
    };
  };
}
