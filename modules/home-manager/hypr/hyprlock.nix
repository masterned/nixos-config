{ ... }:
{
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        disable_loading_bar = true;
        pam_module = "system-auth";
        hide_cursor = false;
        no_fade_in = false;
      };

      background = {
        color = "rgba(000000ff)";
        path = "/home/spencer/Workspaces/nixos/assets/images/neo_EPCOT.jpg";
        blur_passes = 2;
        blur_size = 5;
      };

      input-field = [
        {
          monitor = "";
          size = "500, 100";
          outline_thickness = 3;
          dots_size = 0.2;
          dots_spacing = 0.6;
          outer_color = "rgba(3b3b3b55)";
          inner_color = "rgba(33333311)";
          font_color = "rgba(ffffffff)";

          position = "0, 20";
          halign = "center";
          valign = "center";
        }
      ];

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
