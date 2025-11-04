{
  pkgs,
  outputs,
  ...
}:

{
  imports = [
    outputs.homeManagerModules.gnome-software
    outputs.homeManagerModules.helix
    outputs.homeManagerModules.hypr
    outputs.homeManagerModules.newsboat
    outputs.homeManagerModules.rmpc
    outputs.homeManagerModules.waybar
    outputs.homeManagerModules.zen-browser
  ];

  nixpkgs.config.allowUnfree = true;

  home = {
    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    username = "spencer";
    homeDirectory = "/home/spencer";

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "24.11"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
    # environment.
    packages = with pkgs; [
      brave
      discord
      ffmpeg
      gimp3
      inkscape
      rustup
      signal-desktop
      thunderbird
      typst
    ];

    file = { };

    # > Since I'm using nushell as my default shell, the session
    # > session variables are overwritten by the nushell config.
    # sessionVariables = { };

    shell.enableNushellIntegration = true;
  };

  dconf = {
    enable = true;
    settings = { };
  };

  programs = {
    home-manager.enable = true;

    atuin = {
      enable = true;

      enableNushellIntegration = true;

      settings = {
        auto_sync = false;
        update_check = false;
      };
    };

    bacon.enable = true;

    bat = {
      enable = true;

      extraPackages = with pkgs.bat-extras; [
        core
      ];
    };

    bottom = {
      enable = true;

      settings = {
        flags = {
          battery = true;
          disable_advanced_kill = true;
          temperature_type = "c";
        };

        styles = {
          theme = "nord";
        };
      };
    };

    direnv = {
      enable = true;
      enableNushellIntegration = true;
      nix-direnv.enable = true;
    };

    fzf.enable = true;

    ghostty = {
      enable = true;

      installBatSyntax = true;

      settings = {
        theme = "stylix";
        background-opacity = 0.9;
      };
    };

    jujutsu = {
      enable = true;

      settings = {
        user = {
          email = "mr.spencerdent@gmail.com";
          name = "Spencer Dent";
        };

        ui = {
          default-command = "log";
          pager = ":builtin";
          diff-editor = ":builtin";
        };
      };
    };

    mpv = {
      enable = true;

      package = pkgs.mpv.override {
        scripts = with pkgs.mpvScripts; [
          mpris
          mpv-discord
          skipsilence
        ];
      };

      config = {
        ytdl-format = "bestvideo[height<=?720]+bestaudio";
      };
    };

    nushell = {
      enable = true;

      environmentVariables = {
        NH_FLAKE = "/home/spencer/Workspaces/nixos";
        EDITOR = "hx";
        VISUAL = "hx";
        STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$env.HOME/.steam/root/compatibilitytools.d";
        SSH_AUTH_SOCK = "($env.XDG_RUNTIME_DIR)/ssh-agent";
      };

      extraConfig = # nu
        ''
          $env.config = {
            show_banner: false
            edit_mode: vi
          }
        '';
    };

    obs-studio.enable = true;

    onlyoffice = {
      enable = true;
      settings = {
        UITheme = "theme-dark";
        appdata = "@ByteArray(eyJ1c2VybmFtZSI6InNwZW5jZXIiLCJkb2NvcGVubW9kZSI6ImVkaXQiLCJyZXN0YXJ0Ijp0cnVlLCJsYW5naWQiOiJlbi1VUyIsInVpc2NhbGluZyI6IjEwMCIsInVpdGhlbWUiOiJ0aGVtZS1kYXJrIiwiZWRpdG9yd2luZG93bW9kZSI6ZmFsc2UsInJ0bCI6ZmFsc2UsInVzZWdwdSI6dHJ1ZX0=)";
        editorWindowMode = false;
        forcedRtl = false;
        lastPrinterName = "";
        openPath = "/home/spencer/Pictures";
        position = "@Rect(12 48 1416 900)";
        savePath = "/home/spencer/Documents";
        titlebar = "custom";
      };
    };

    ripgrep.enable = true;

    starship.enable = true;

    tealdeer.enable = true;

    # thunderbird = {
    #   enable = true;

    #   profiles.default = {
    #     isDefault = true;
    #   };
    # };

    yazi = {
      enable = true;
      enableNushellIntegration = true;
    };

    yt-dlp = {
      enable = true;

      settings = {
        embed-chapters = true;

        embed-subs = true;
        sub-langs = "en";

        embed-thumbnail = true;
      };
    };

    zathura = {
      enable = true;
    };

    zoxide.enable = true;
  };

  services = {
    gpg-agent = {
      enable = true;
    };

    mpd = {
      enable = true;

      extraConfig = # config
        ''
          audio_output {
            type "pipewire"
            name "PipeWire Sound Server"
          }

          audio_output {
            type "fifo"
            name "mpd_fifo"
            path "/tmp/mpd.fifo"
            format "44100:16:2"
          }

          auto_update "yes"

          bind_to_address "/tmp/mpd_socket"
        '';
    };

    mpd-discord-rpc.enable = true;
    mpd-mpris.enable = true;

    remmina.enable = true;
  };

  stylix.targets = {
    helix.enable = false;
    hyprlock.enable = false;
  };

  xdg = {
    enable = true;

    mimeApps = {
      enable = true;
      associations.added = {
        "application/pdf" = [ "org.pwmt.zathura.desktop" ];
        "image/jpeg" = [ "imv.desktop" ];
        "image/png" = [ "imv.desktop" ];
      };
      defaultApplications = {
        "application/pdf" = [ "org.pwmt.zathura.desktop" ];
        "image/jpeg" = [ "imv.desktop" ];
        "image/png" = [ "imv.desktop" ];
      };
    };

    userDirs.enable = true;
  };
}
