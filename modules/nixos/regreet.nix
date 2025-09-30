{ ... }:
{
  programs.regreet = {
    enable = true;

    font = {
      name = "DejaVu Sans";
    };

    settings = {
      default_session = {
        command = "uwsm start hyprland-uwsm.desktop";
        user = "greeter";
      };

      gtk = {
        application_prefer_dark_theme = true;
      };

      commands = {
        reboot = [
          "systemctl"
          "reboot"
        ];
        poweroff = [
          "systemctl"
          "poweroff"
        ];
        x11_prefix = [
          "startx"
          "/usr/bin/env"
        ];
      };

      appearance = {
        greeting_msg = "Make sure to get some sleep!";
      };

      widget = {
        clock = {
          format = "%a %Y-%m-%d %H:%M:%S";
          resolution = "500ms";
          timezone = "America/NewYork";
          label_width = 150;
        };
      };
    };
  };

  security.pam.services.greetd = {
    enable = true;
    enableGnomeKeyring = true;
  };
}
