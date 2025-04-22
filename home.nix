{
  pkgs,
  outputs,
  lib,
  ...
}:

{
  imports = [
    outputs.homeManagerModules.hypr
  ];

  nixpkgs = {
    config.allowUnfree = true;

    overlays = with outputs.overlays; [
      modifications
      stable-packages
    ];
  };

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "spencer";
  home.homeDirectory = "/home/spencer";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/spencer/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  home.shell.enableNushellIntegration = true;

  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        disable-user-extensions = false;
        enabled-extensions = with pkgs.gnomeExtensions; [
          pop-shell.extensionUuid
        ];
      };
      "org/gnome/shell/extensions/pop-shell" = {
        active-hint = true;
        active-hint-border-radius = "uint32 5";
        hint-color-rgba = "rgba(153,211,255,0.9)";
        tile-by-default = true;
        gap-inner = "uint32 2";
        gap-outer = "uint32 2";
      };
      "org/gnome/desktop/wm/preferences" = {
        focus-mode = "mouse";
      };
    };
  };

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;

    fuzzel = {
      enable = true;
      settings = {
        main = {
          font = lib.mkForce "DejaVu Sans:size=16";
        };
      };
    };

    fzf.enable = true;

    helix = {
      enable = true;

      defaultEditor = true;

      languages = {
        language-server = {
          nixd = {
            command = "${pkgs.nixd}/bin/nixd";
          };
        };
        language = [
          {
            name = "nix";
            language-servers = [ "nixd" ];
          }
        ];
      };

      settings = {
        editor = {
          line-number = "relative";
          mouse = false;
          lsp.display-messages = true;

          cursor-shape = {
            insert = "bar";
            normal = "block";
            select = "underline";
          };

          file-picker = {
            hidden = false;
          };
        };
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

      config = {
        ytdl-format = "bestvideo[height<=?720]+bestaudio";
      };
    };

    newsboat = {
      enable = true;

      extraConfig = ''
        macro v set browser "mpv %u" ; open-in-browser ; set browser "${pkgs.xdg-utils}/bin/xdg-open"
      '';

      urls = [
        {
          title = "Brodie Robertson";
          tags = [
            "linux"
            "youtube"
          ];
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCld68syR8Wi-GY_n4CaoJGA";
        }
        {
          title = "Continuous Delivery";
          tags = [
            "software-development"
            "youtube"
          ];
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCCfqyGl3nq_V0bo64CjZh8g";
        }
        {
          title = "Cowboy Kent Rollins";
          tags = [
            "food"
            "youtube"
          ];
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UClrMJRlvoyoWsVlB-7c61PQ";
        }
        {
          title = "DFBGuide";
          tags = [
            "disney"
            "youtube"
          ];
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCnpWedLQdHpZqhgTLdB9Yyg";
        }
        {
          title = "Disney Parks";
          tags = [
            "disney"
            "youtube"
          ];
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC1xwwLwm6WSMbUn_Tp597hQ";
        }
        {
          title = "Dogen";
          tags = [
            "japanese"
            "youtube"
          ];
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCSX0NhNdBA-ZnEFkYFzdw4A";
        }
        {
          title = "Dreams of Autonomy";
          tags = [
            "youtube"
          ];
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCEEVcDuBRDiwxfXAgQjLGug";
        }
        {
          title = "Dreams of Code";
          tags = [
            "software-development"
            "youtube"
          ];
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCWQaM7SpSECp9FELz-cHzuQ";
        }
        {
          title = "Driving 4 Answers";
          tags = [
            "engineering"
            "youtube"
          ];
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCwosUnVH6AINmxtqkNJ3Fbg";
        }
        {
          title = "Feral Foraging";
          tags = [
            "food"
            "youtube"
          ];
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCmngd6QbE67Dvc9kRnrlToA";
        }
        {
          title = "FortNine";
          tags = [
            "engineering"
            "youtube"
          ];
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCNSMdQtn1SuFzCZjfK2C7dQ";
        }
        {
          title = "Jacob Sorber";
          tags = [
            "software-development"
            "youtube"
          ];
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCwd5VFu4KoJNjkWJZMFJGHQ";
        }
        {
          title = "Jeremy Chone";
          tags = [
            "rust"
            "software-development"
            "youtube"
          ];
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCiT_r1GD7JSftnbViKHcOtQ";
        }
        {
          title = "Jon Gjengset";
          tags = [
            "rust"
            "software-development"
            "youtube"
          ];
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC_iD0xppBwwsrM9DegC5cQQ";
        }
        {
          title = "Logan Smith";
          tags = [
            "rust"
            "software-development"
            "youtube"
          ];
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCnHX5FjwtQpxkCGziuh4NJA";
        }
        {
          title = "Mental Outlaw";
          tags = [
            "linux"
            "youtube"
          ];
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC7YOGHUfC1Tb6E4pudI9STA";
        }
        {
          title = "Sorcerer Radio";
          tags = [
            "disney"
            "music"
            "youtube"
          ];
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCKSs6PXgeYDSHTcGdaItJYw";
        }
        {
          title = "Technology Connections";
          tags = [
            "linux"
            "youtube"
          ];
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCy0tKL1T7wFoYcxCe0xjN6Q";
        }
        {
          title = "The Dungeon Coach";
          tags = [
            "ttrpgs"
            "youtube"
          ];
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCz8xkTADYdRQR7GP-f2PjOA";
        }
        {
          title = "Vimjoyer";
          tags = [
            "technology"
            "youtube"
          ];
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC_zBdZ0_H_jn41FDRG7q4Tw";
        }
        {
          title = "Walt Disney Imagineering";
          tags = [
            "disney"
            "youtube"
          ];
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC4DavIB24rEr5waVY5AgZLg";
        }
        {
          title = "Zee Bashew";
          tags = [
            "dnd"
            "ttrpgs"
            "youtube"
          ];
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCCXR2kCo7Lcw_BKwWxo09kw";
        }
      ];
    };

    nushell = {
      enable = true;
      extraConfig = ''
        $env.config = {
          show_banner: false
          edit_mode: vi
        }
      '';
      extraEnv = ''
        $env.FLAKE = "/home/spencer/Workspaces/nixos"
        $env.EDITOR = "hx"
        $env.VISUAL = "hx"
      '';
    };

    starship.enable = true;

    waybar = {
      enable = true;

      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 30;

          output = [
            "eDP-1"
          ];

          modules-left = [
            "hyprland/workspaces"
            "hyprland/window"
          ];
          modules-center = [
            "mpd"
            "clock"
          ];
          modules-right = [
            "temperature"
            "battery"
            "bluetooth"
            "network"
          ];

          clock = {
            interval = 1;
            format = "{:%Y-%m-%d %H:%M:%S}";
          };

          network = {
            "format-wifi" = "{essid} ({signalStrength}%) ";
            "format-ethernet" = "{ipadder}/{cidr} ";
          };
        };
      };
    };

    wezterm = {
      enable = true;

      extraConfig = ''
        local wezerm = require 'wezterm'

        local config = wezterm.config_builder()

        config.hide_tab_bar_if_only_one_tab = true

        config.check_for_updates = false

        return config
      '';
    };

    yazi = {
      enable = true;
      enableNushellIntegration = true;
    };

    zoxide.enable = true;
  };

  services = {
    mpd = {
      enable = true;

      extraConfig = ''
        audio_output {
          type "pipewire"
          name "PipeWire Sound Server"
        }
        auto_update "yes"
      '';

      musicDirectory = "/home/spencer/Music";
    };

    mpd-mpris.enable = true;
  };

  stylix.targets.hyprlock.enable = false;

  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "x-scheme-handler/http" = [ "zen-beta.desktop" ];
      "x-scheme-handler/https" = [ "zen-beta.desktop" ];
      "x-scheme-handler/chrome" = [ "zen-beta.desktop" ];
      "text/html" = [ "zen-beta.desktop" ];
      "application/x-extension-htm" = [ "zen-beta.desktop" ];
      "application/x-extension-html" = [ "zen-beta.desktop" ];
      "application/x-extension-shtml" = [ "zen-beta.desktop" ];
      "application/xhtml+xml" = [ "zen-beta.desktop" ];
      "application/x-extension-xhtml" = [ "zen-beta.desktop" ];
      "application/x-extension-xht" = [ "zen-beta.desktop" ];
      "application/pdf" = [ "org.pwmt.zathura.desktop" ];
      "image/jpeg" = [ "org.gnome.Loupe.desktop" ];
      "image/png" = [ "org.gnome.Loupe.desktop" ];
    };
    defaultApplications = {
      "x-scheme-handler/http" = [ "zen-beta.desktop" ];
      "x-scheme-handler/https" = [ "zen-beta.desktop" ];
      "x-scheme-handler/chrome" = [ "zen-beta.desktop" ];
      "text/html" = [ "zen-beta.desktop" ];
      "application/x-extension-htm" = [ "zen-beta.desktop" ];
      "application/x-extension-html" = [ "zen-beta.desktop" ];
      "application/x-extension-shtml" = [ "zen-beta.desktop" ];
      "application/xhtml+xml" = [ "zen-beta.desktop" ];
      "application/x-extension-xhtml" = [ "zen-beta.desktop" ];
      "application/x-extension-xht" = [ "zen-beta.desktop" ];
      "application/pdf" = [ "org.pwmt.zathura.desktop" ];
      "image/jpeg" = [ "org.gnome.Loupe.desktop" ];
      "image/png" = [ "org.gnome.Loupe.desktop" ];
    };
  };
}
