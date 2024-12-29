{ config, lib, ... }:
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
        path = "/home/spencer/Workspaces/nixos/assets/images/spaceMountain_conceptArt.jpg";
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
          text = "$TIME";
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

  services = {
    hypridle = {
      enable = true;

      settings = {
        general = {
          before_sleep_cmd = "loginctl lock-session";
          after_sleep_cmd = "hyprctl dispatch dpms on";
          lock_cmd = "pidof hyprlock || hyprlock";
        };

        listener = [
          # Turn down screen brightness after 1.5mins
          {
            timeout = 150;
            on-timeout = "brightnessctl -s set 10";
            on-resume = "brightnessctl -r";
          }
          # Turn off keyboard backlight after 1.5mins
          {
            timeout = 150;
            on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0";
            on-resume = "brightnessctl -rd rgb:kbd_backlight";
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

    hyprpaper = {
      enable = true;

      settings = {
        preload = [
          "/home/spencer/Workspaces/nixos/assets/images/spaceMountain_conceptArt.jpg"
        ];

        wallpaper = [
          "/home/spencer/Workspaces/nixos/assets/images/spaceMountain_conceptArt.jpg"
        ];

        splash = false;
      };
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      monitor = ",preferred,auto,auto";

      env = [
        "XCURSOR_THEME,Bibata-Original-Ice"
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      "exec-once" = [
        "hyprpaper"
        "hypridle"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;

        border_size = 2;

        resize_on_border = false;

        allow_tearing = false;

        layout = "dwindle";
      };

      decoration = {
        rounding = 10;

        active_opacity = 1.0;
        inactive_opacity = 0.9;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;
          vibrancy = 0.1696;
        };
      };

      animations = {
        enabled = true;

        bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";

        animation = [
          "windows, 1, 7, myBezier"
          "windowsOut, 1, 7, default, popin 80%"
          "border, 1, 10, default"
          "borderangle, 1, 8, default"
          "fade, 1, 7, default"
          "workspaces, 1, 6, default"
        ];
      };

      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = false;
        };
      };

      gestures = {
        workspace_swipe = false;
      };

      "$mod" = "SUPER";

      bind = [
        "CTRL ALT, DELETE, exit"
        "SUPER, T, exec, [floating; tile] wezterm start --always-new-process"
        "SUPER, Q, killactive"
        "SUPER, ESCAPE, exec, hyprlock"
        "SUPER, F, exec, nautilus"
        "SUPER, B, exec, floorp"
        "SUPER, M, exec, discord"
        "SUPER, V, exec, alacritty --class clipse -e clipse"

        "SUPER, left, movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up, movefocus, u"
        "SUPER, down, movefocus, d"

        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"
        "SUPER, 0, workspace, 10"

        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        "SUPER SHIFT, 6, movetoworkspace, 6"
        "SUPER SHIFT, 7, movetoworkspace, 7"
        "SUPER SHIFT, 8, movetoworkspace, 8"
        "SUPER SHIFT, 9, movetoworkspace, 9"
        "SUPER SHIFT, 0, movetoworkspace, 10"

        "SUPER, S, togglespecialworkspace, magic"
        "SUPER SHIFT, S, movetoworkspace, special:magic"

        "SUPER, mouse_down, workspace, e+1"
        "SUPER, mouse_up, workspace, e-1"
        "SUPER, mouse_left, workspace, e+1"
        "SUPER, mouse_right, workspace, e-1"

        ", Print, exec, grimblast copy area \"$(slurp -d)\""
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bindr = [
        "SUPER, SUPER_L, exec, pkill fuzzel || fuzzel"
      ];

      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl set 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl set 10%-"
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioPrev, exec, playerctl previous"
        ",XF86AudioNext, exec, playerctl next"
      ];

      windowrulev2 = [
        "suppressevent maximize, class:.*"
        "float, class:(clipse)"
        "size 622 652, class:(clipse)"
      ];
    };
  };
}
