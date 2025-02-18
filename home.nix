{
  config,
  pkgs,
  inputs,
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
          title = "Dreams of Autonomy";
          tags = [
            "youtube"
          ];
          url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCEEVcDuBRDiwxfXAgQjLGug";
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
  };

  stylix.targets.hyprlock.enable = false;

  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "x-scheme-handler/http" = ["floorp.desktop"];
      "x-scheme-handler/https" = ["floorp.desktop"];
      "x-scheme-handler/chrome" = ["floorp.desktop"];
      "text/html" = ["floorp.desktop"];
      "application/x-extension-htm" = ["floorp.desktop"];
      "application/x-extension-html" = ["floorp.desktop"];
      "application/x-extension-shtml" = ["floorp.desktop"];
      "application/xhtml+xml" = ["floorp.desktop"];
      "application/x-extension-xhtml" = ["floorp.desktop"];
      "application/x-extension-xht" = ["floorp.desktop"];
      "application/pdf" = ["org.pwmt.zathura.desktop"];
      "image/jpeg" = ["org.gnome.Loupe.desktop"];
      "image/png" = ["org.gnome.Loupe.desktop"];
    };
    defaultApplications = {
      "x-scheme-handler/http" = ["floorp.desktop"];
      "x-scheme-handler/https" = ["floorp.desktop"];
      "x-scheme-handler/chrome" = ["floorp.desktop"];
      "text/html" = ["floorp.desktop"];
      "application/x-extension-htm" = ["floorp.desktop"];
      "application/x-extension-html" = ["floorp.desktop"];
      "application/x-extension-shtml" = ["floorp.desktop"];
      "application/xhtml+xml" = ["floorp.desktop"];
      "application/x-extension-xhtml" = ["floorp.desktop"];
      "application/x-extension-xht" = ["floorp.desktop"];
      "application/pdf" = ["org.pwmt.zathura.desktop"];
      "image/jpeg" = ["org.gnome.Loupe.desktop"];
      "image/png" = ["org.gnome.Loupe.desktop"];
    };
  };
}
