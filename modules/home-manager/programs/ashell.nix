{ config, lib, ... }:
{
  programs.ashell = {
    enable = true;
    settings = {
      appearance = with config.lib.stylix.colors.withHashtag; {
        workspace_colors = lib.mkForce [ base0D ];
      };
      clock = {
        format = "%F %X";
      };
      media_player = {
        max_title_length = 55;
      };
      modules = {
        center = [
          "Clock"
        ];
        left = [
          "Workspaces"
          [
            "WindowTitle"
          ]
        ];
        right = [
          "MediaPlayer"
          [
            "SystemInfo"
          ]
          [
            "Settings"
          ]
        ];
      };
      settings = {
        shutdown_cmd = "systemctl poweroff";
        suspend_cmd = "systemctl suspend";
        reboot_cmd = "systemctl reboot";
        audio_sinks_more_cmd = "pavucontrol -t 3";
        audio_sources_more_cmd = "pavucontrol -t 4";
        wifi_more_cmd = "nm-connection-editor";
        vpn_more_cmd = "nm-connection-editor";
        bluetooth_more_cmd = "blueman-manager";
        lock_cmd = "hyprlock & (sleep 1 && hyprctl dispatch dpms off)";
        logout_cmd = "uwsm stop";
        remove_airplane_btn = true;
        remove_idle_btn = true;
      };
      workspaces = {
        visibility_mode = "MonitorSpecific";
      };
      window_title = {
        truncate_title_after_length = 75;
      };
    };
    systemd.enable = true;
  };
}
