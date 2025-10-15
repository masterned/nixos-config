{ pkgs, inputs, ... }:
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

  services = {
    hypridle = {
      enable = true;

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

    hyprpaper = {
      enable = true;
    };

    hyprsunset = {
      enable = true;

      settings = {
        max-gamma = 150;

        profile = [
          {
            time = "7:30";
            identity = true;
          }
          {
            time = "18:00";
            temperature = 4500;
            gamma = 0.8;
          }
        ];
      };
    };
  };

  wayland.windowManager.hyprland = {
    enable = true;

    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    plugins = [
    ];

    settings = {
      debug = {
        disable_logs = false;
        enable_stdout_logs = true;
      };

      monitor = [
        ",preferred,auto,auto"
      ];

      workspace = [
        "eDP-1,1"
        "DP-2,11"
        "1,monitor:eDP-1"
        "2,monitor:eDP-1"
        "3,monitor:eDP-1"
        "4,monitor:eDP-1"
        "5,monitor:eDP-1"
        "6,monitor:eDP-1"
        "7,monitor:eDP-1"
        "8,monitor:eDP-1"
        "9,monitor:eDP-1"
        "11,monitor:DP-2"
        "12,monitor:DP-2"
        "13,monitor:DP-2"
        "14,monitor:DP-2"
        "15,monitor:DP-2"
        "16,monitor:DP-2"
        "17,monitor:DP-2"
        "18,monitor:DP-2"
        "19,monitor:DP-2"
      ];

      env = [
        "XCURSOR_THEME,Bibata-Original-Ice"
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      "exec-once" = [
        "hypridle"
        "systemctl --user start hyprpolkitagent"
        "swaync"
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

        # screen_shader = "/home/spencer/Workspaces/nixos/modules/home-manager/extra_dark.frag";
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
        mouse_move_enables_dpms = true;
        key_press_enables_dpms = true;
        enable_swallow = true;
        swallow_regex = "^com\.mitchellh\.ghostty$";
        vfr = true;
      };

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = {
          natural_scroll = false;
        };
      };

      gesture = [
        "3, horizontal, workspace"
      ];

      gestures = {
        workspace_swipe_invert = false;
      };

      group = {
        groupbar = {
          font_size = 20;
          height = 28;
        };
      };

      "$mod" = "SUPER";

      bind = [
        "CTRL ALT, DELETE, exec, uwsm stop"
        "SUPER, T, exec, ghostty"
        "SUPER, Q, killactive"
        "SUPER, ESCAPE, exec, hyprlock & (sleep 1 && hyprctl dispatch dpms off)"
        "SUPER, F, exec, nautilus"
        "SUPER, B, exec, zen-beta"
        "SUPER, M, exec, discord"
        "SUPER, V, exec, alacritty --class clipse -e clipse"

        "SUPER, left, movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up, movefocus, u"
        "SUPER, down, movefocus, d"

        "SUPER, H, movefocus, l"
        "SUPER, L, movefocus, r"
        "SUPER, K, movefocus, u"
        "SUPER, J, movefocus, d"

        "SUPER, 1, exec, hyprsome workspace 1"
        "SUPER, 2, exec, hyprsome workspace 2"
        "SUPER, 3, exec, hyprsome workspace 3"
        "SUPER, 4, exec, hyprsome workspace 4"
        "SUPER, 5, exec, hyprsome workspace 5"
        "SUPER, 6, exec, hyprsome workspace 6"
        "SUPER, 7, exec, hyprsome workspace 7"
        "SUPER, 8, exec, hyprsome workspace 8"
        "SUPER, 9, exec, hyprsome workspace 9"

        "SUPER SHIFT, 1, exec, hyprsome move 1"
        "SUPER SHIFT, 2, exec, hyprsome move 2"
        "SUPER SHIFT, 3, exec, hyprsome move 3"
        "SUPER SHIFT, 4, exec, hyprsome move 4"
        "SUPER SHIFT, 5, exec, hyprsome move 5"
        "SUPER SHIFT, 6, exec, hyprsome move 6"
        "SUPER SHIFT, 7, exec, hyprsome move 7"
        "SUPER SHIFT, 8, exec, hyprsome move 8"
        "SUPER SHIFT, 9, exec, hyprsome move 9"

        "SUPER, S, togglespecialworkspace, magic"
        "SUPER SHIFT, S, movetoworkspace, special:magic"
        "SUPER, G, togglegroup"

        "SUPER, mouse_down, workspace, e+1"
        "SUPER, mouse_up, workspace, e-1"
        "SUPER, mouse_left, workspace, e+1"
        "SUPER, mouse_right, workspace, e-1"

        ", Print, exec, grimblast copysave area ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png"
        "CTRL, Print, exec, pkill wl-screenrec || wl-screenrec -g \"$(slurp)\""
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
        ",XF86MonBrightnessUp, exec, brightnessctl set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
        ",XF86AudioPlay, exec, playerctl play-pause"
        ",XF86AudioPrev, exec, playerctl previous"
        ",XF86AudioNext, exec, playerctl next"
      ];

      plugin = {
        hyprexpo = {
          columns = 3;
          gap_size = 5;
          bg_col = "rgb(111111)";
          workspace_method = "center current";

          enable_gesture = true;
          gesture_fingers = 3;
          gesture_distance = 300;
          gesture_positive = true;
        };
      };

      windowrule = [
        "suppressevent maximize, class:.*"
        "float, class:(clipse)"
        "size 622 652, class:(clipse)"
        "idleinhibit focus, fullscreen: 1"
      ];
    };

    systemd = {
      enable = false;
      variables = [ "--all" ];
    };
  };
}
