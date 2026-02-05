{ ... }: {
  services.displayManager.ly = {
    enable = true;
    settings = {
      allow_empty_passsword = true;
      animation = "matrix";
      animation_timeout_sec = 0;
      asterisk = "*";
      auth_fails = 10;
      auto_login_session = "hyprland-uwsm";
      auto_login_user = "spencer";
      battery_id = "BAT1";
      bg = "0x00000000";
      bigclock = "en";
      bigclock_12hr = false;
      bigclock_seconds = true;
      blank_box = true;
      border_fg = "0x0099d3ff";
      box_title = null;
      clear_password = true;
      clock = null;
      cmatrix_fg = "0x008abee5";
      cmatric_head_col = "0x0199d3ff";
      cmatrix_min_codepoint = "0x03b1";
      cmatrix_max_codepoint = "0x03c9";
      default_input = "login";
      error_bg = "0x00000000";
      error_fg = "0x01ff0000";
      fg = "0x00ffffff";
      full_color = true;
      input_len = 34;
      lang = "en";
      load = false;
      ly_log = "/var/log/ly.log";
      margin_box_h = 2;
      margin_box_v = 1;
      numlock = false;
      save = false;
      service_name = "ly";
      session_log = ".local/state/ly-session.log";
      vi_default_mode = "normal";
      vi_mode = true;
      waylandsessions = "/home/spencer/.nix-profile/share/wayland-sessions";
    };
    x11Support = false;
  };
  security.pam.services.ly = {
    enable = true;
    enableGnomeKeyring = true;
  };
}
