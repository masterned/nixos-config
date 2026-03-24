{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    grimblast
    hyprpolkitagent
    hyprsysteminfo
    slurp
    wl-screenrec
  ];
  imports = [ ];
  services = {
    udiskie = {
      enable = true;
    };
  };
  wayland.windowManager.hyprland = {
    enable = true;
    plugins = [ ];
    settings = {
      debug = {
        disable_logs = false;
        enable_stdout_logs = true;
      };

      cursor = { };

      monitor = [
        ",preferred,auto,auto"
      ];

      env = [
        "XCURSOR_THEME,Bibata-Original-Ice"
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      "exec-once" = [
        "noctalia-shell"
        "systemctl --user start hyprpolkitagent"
      ];

      general = {
        allow_tearing = false;

        border_size = 2;

        gaps_in = 5;
        gaps_out = 10;

        layout = "dwindle";

        resize_on_border = false;
      };

      decoration = {
        blur = {
          enabled = true;
          passes = 2;
          size = 3;
          vibrancy = 0.1696;
        };

        # opacity
        active_opacity = 1.0;
        inactive_opacity = 0.9;

        # rounding
        rounding = 10;
        rounding_power = 2;

        shadow = {
          enabled = true;
          color = lib.mkDefault "rgba(1a1a1aee)";
          range = 4;
          render_power = 3;
        };
      };

      animations = {
        enabled = true;
        bezier = [
          # NAME,          X0,   Y0,   X1,   Y1
          "easeOutQuint,   0.23, 1,    0.32, 1"
          "easeInOutCubic, 0.65, 0.05, 0.36, 1"
          "linear,         0,    0,    1,    1"
          "almostLinear,   0.5,  0.5,  0.75, 1"
          "quick,          0.15, 0,    0.1,  1"
        ];
        animation = [
          # NAME,         ONOFF, SPEED, CURVE,        [STYLE]
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

      layerrule = [
        {
          name = "noctalia";
          "match:namespace" = "noctalia-background-.*$";
          ignore_alpha = 0.5;
          blur = true;
          blur_popups = true;
        }
      ];

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

      "$ipc" = "noctalia-shell ipc call";

      bind = [
        "CTRL ALT, DELETE, exec, uwsm stop"
        "SUPER, T, exec, uwsm app -- ghostty"
        "SUPER, Q, killactive"
        "SUPER, ESCAPE, exec, $ipc lockScreen lock"
        "SUPER, F, exec, uwsm app -- nautilus"
        "SUPER, B, exec, uwsm app -- zen-twilight"
        "SUPER, M, exec, uwsm app -- discord"

        "SUPER, left, movefocus, l"
        "SUPER, right, movefocus, r"
        "SUPER, up, movefocus, u"
        "SUPER, down, movefocus, d"

        "SUPER, H, movefocus, l"
        "SUPER, L, movefocus, r"
        "SUPER, K, movefocus, u"
        "SUPER, J, movefocus, d"

        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"

        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"

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
        "SUPER, mouse:272, movewindow"
        "SUPER, mouse:273, resizewindow"
      ];

      bindr = [
        "SUPER, SUPER_L, exec, $ipc launcher toggle"
      ];

      bindel = [
        # Brightness
        ",XF86MonBrightnessDown, exec, $ipc brightness decrease"
        ",XF86MonBrightnessUp, exec, $ipc brightness increase"

        # Volume
        ",XF86AudioLowerVolume, exec, $ipc volume decrease"
        ",XF86AudioRaiseVolume, exec, $ipc volume increase"
      ];

      bindl = [
        # Media
        ",XF86AudioPrev, exec, $ipc media previous"
        ",XF86AudioPlay, exec, $ipc media playPause"
        ",XF86AudioNext, exec, $ipc media next"

        # Volume
        ",XF86AudioMicMute, exec, $ipc volumne muteInput"
        ",XF86AudioMute, exec, $ipc volume muteOutput"
      ];

      plugin = { };

      windowrule = [
        {
          # Ignore maximize requests from all apps. You'll probably like this.
          name = "suppress-maximize-events";
          "match:class" = ".*";
          suppress_event = "maximize";
        }
        {
          # Fix some dragging issues with XWayland
          name = "fix-xwayland-drags";
          "match:class" = "^$";
          "match:title" = "^$";
          "match:xwayland" = true;
          "match:float" = true;
          "match:fullscreen" = false;
          "match:pin" = false;
          no_focus = true;
        }
      ];
    };
    systemd = {
      enable = false;
      variables = [ "--all" ];
    };
  };
  xdg.configFile."uwsm/env".source =
    "${config.home.sessionVariablesPackage}/etc/profile.d/hm-session-vars.sh";
}
