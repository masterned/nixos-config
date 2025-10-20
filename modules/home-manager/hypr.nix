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
      inputs.split-monitor-workspaces.packages.${pkgs.system}.split-monitor-workspaces
    ];

    settings = {
      debug = {
        disable_logs = false;
        enable_stdout_logs = true;
      };

      monitor = [
        ",preferred,auto,auto"
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
      };

      animations = {
        enabled = true;

        bezier = [
          # NAME,            X0,   Y0,   X1,   Y1
          "easeOutQuint,   0.23, 1,    0.32, 1"
          "easeInOutCubic, 0.65, 0.05, 0.36, 1"
          "linear,         0,    0,    1,    1"
          "almostLinear,   0.5,  0.5,  0.75, 1"
          "quick,          0.15, 0,    0.1,  1"
        ];

        animation = [
        # NAME,           ONOFF, SPEED, CURVE,        [STYLE]
          "global,        1,     10,    default"
          "border,        1,     5.39,  easeOutQuint"
          "borderangle,   1,     8,     default"
          "windows,       1,     4.79,  easeOutQuint"
          "windowsIn,     1,     4.1,   easeOutQuint, popin 87%"
          "windowsOut,    1,     1.49,  linear,       popin 87%"
          "fadeIn,        1,     1.73,  almostLinear"
          "fadeOut,       1,     1.46,  almostLinear"
          "fade,          1,     3.03,  quick"
          "layers,        1,     3.81,  easeOutQuint"
          "layersIn,      1,     4,     easeOutQuint, fade"
          "layersOut,     1,     1.5,   linear,       fade"
          "fadeLayersIn,  1,     1.79,  almostLinear"
          "fadeLayersOut, 1,     1.39,  almostLinear"
          "workspaces,    1,     6,     default"
          "workspacesIn,  1,     6,     default"
          "workspacesOut, 1,     6,     default"
          "zoomFactor,    1,     7,     quick"
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
        "3, down, special, magic"
        "3, horizontal, workspace"
        "3, up, fullscreen"
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

        "SUPER, 1, split-workspace, 1"
        "SUPER, 2, split-workspace, 2"
        "SUPER, 3, split-workspace, 3"
        "SUPER, 4, split-workspace, 4"
        "SUPER, 5, split-workspace, 5"

        "SUPER SHIFT, 1, split-movetoworkspacesilent, 1"
        "SUPER SHIFT, 2, split-movetoworkspacesilent, 2"
        "SUPER SHIFT, 3, split-movetoworkspacesilent, 3"
        "SUPER SHIFT, 4, split-movetoworkspacesilent, 4"
        "SUPER SHIFT, 5, split-movetoworkspacesilent, 5"

        "SUPER, S, togglespecialworkspace, magic"
        "SUPER SHIFT, S, movetoworkspace, special:magic"
        "SUPER, G, togglegroup"

        "SUPER, mouse_down, workspace, m+1"
        "SUPER, mouse_up, workspace, m-1"
        "SUPER, mouse_left, workspace, m+1"
        "SUPER, mouse_right, workspace, m-1"

        "SUPER, mouse:274, killactive"
        "SUPER, mouse:275, workspace, m+1"
        "SUPER, mouse:276, workspace, m-1"

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
        "split-monitor-workspaces" = {
          count = 10;
          keep_focused = 0;
          enable_notifications = 0;
          enable_persistent_workspaces = 0;
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
