{ pkgs, inputs, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;
in
{
  home.packages = with pkgs; [
    brightnessctl
    grimblast
    hyprpolkitagent
    slurp
    swaynotificationcenter
    wl-screenrec
  ];

  imports = [
    ./hyprlock.nix
    ./hypridle.nix
    ./hyprsunset.nix
  ];

  services = {
    hyprlauncher = {
      enable = true;
      settings = {
        finders.desktop_launch_prefix = "uwsm app -- ";
      };
    };

    hyprpaper.enable = true;
  };

  wayland.windowManager.hyprland =
    let
      hypr-pkgs = inputs.hyprland.packages;
    in
    {
      enable = true;

      package = hypr-pkgs.${system}.hyprland;
      portalPackage = hypr-pkgs.${system}.xdg-desktop-portal-hyprland;

      plugins = [
        inputs.split-monitor-workspaces.packages.${system}.split-monitor-workspaces
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
          "swaync"
          "systemctl --user start hyprpolkitagent"
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
          "SUPER, T, exec, uwsm app -- ghostty"
          "SUPER, Q, killactive"
          "SUPER, ESCAPE, exec, hyprlock & (sleep 1 && hyprctl dispatch dpms off)"
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
          "$mod, mouse:272, movewindow"
          "$mod, mouse:273, resizewindow"
        ];

        bindr = [
          "SUPER, SUPER_L, exec, hyprlauncher"
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
}
