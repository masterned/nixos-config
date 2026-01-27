{ inputs, pkgs, ... }:
{
  programs.hyprlock = {
    enable = true;
    package = inputs.hyprlock.packages.${pkgs.stdenv.hostPlatform.system}.default;

    settings = {
      general = {
        disable_loading_bar = true;
        pam_module = "system-auth";
        hide_cursor = false;
        no_fade_in = false;
      };

      background = {
        blur_passes = 2;
        blur_size = 5;
      };

      label = [
        # clock
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +%H:%M:%S)\" ";
          shadow_passes = 2;
          shadow_boost = 0.75;
          color = "rgba(ffffffff)";
          font_size = 130;
          font_family = "DajaVu Sans";

          position = "0, 300";
          halign = "center";
          valign = "center";
        }
        # greeting
        {
          monitor = "";
          text = "Don't forget to get some sleep...";
          shadow_passes = 2;
          shadow_boost = 0.75;
          color = "rgba(ffffffff)";
          font_size = 40;
          font_family = "DajaVu Sans";

          position = "0, 180";
          halign = "center";
          valign = "center";
        }
        # lock icon
        {
          monitor = "";
          text = "lock";
          shadow_passes = 2;
          shadow_boost = 0.75;
          color = "rgba(ffffffff)";
          font_size = 42;
          font_family = "Material Symbols Rounded";

          position = "0, 80";
          halign = "center";
          valign = "bottom";
        }
        # "locked" text
        {
          monitor = "";
          text = "locked";
          shadow_passes = 2;
          shadow_boost = 0.75;
          color = "rgba(ffffffff)";
          font_size = 28;
          font_family = "DajaVu Sans";

          position = "0, 45";
          halign = "center";
          valign = "bottom";
        }
      ];
    };
  };
}
