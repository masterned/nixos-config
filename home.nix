{
  pkgs,
  outputs,
  lib,
  ...
}:

{
  imports = [
    outputs.homeManagerModules.helix
    outputs.homeManagerModules.hypr
    outputs.homeManagerModules.newsboat
    outputs.homeManagerModules.rmpc
    outputs.homeManagerModules.waybar
    outputs.homeManagerModules.youtube-tui
    outputs.homeManagerModules.zen-browser
  ];

  nixpkgs = {
    config.allowUnfree = true;

    overlays = with outputs.overlays; [
      modifications
      stable-packages
    ];
  };

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
      bacon
      bat
      brave
      cargo-expand
      discord
      ffmpeg
      fzf
      ghostty
      gimp3
      gnome-calculator
      gnome-calendar
      gnome-characters
      gnome-clocks
      gnome-disk-utility
      gnome-font-viewer
      gnome-text-editor
      inkscape
      loupe
      nautilus
      obs-studio
      seahorse
      helvum
      mangohud
      newsboat
      onlyoffice-desktopeditors
      posting
      protonup
      remmina
      ripgrep
      rmpc
      rustup
      signal-desktop
      taskwarrior3
      thunderbird
      yt-dlp
      youtube-tui
      zathura
      zoxide
    ];

    file = {
      ".config/ghostty/config".text = # config
        ''
          theme = Nord
          background-opacity = 0.9
        '';
    };

    # > Since I'm using nushell as my default shell, the session
    # > session variables are overwritten by the nushell config.
    # sessionVariables = { };

    shell.enableNushellIntegration = true;
  };

  dconf = {
    enable = true;
    settings = { };
  };

  # Let Home Manager install and manage itself.
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

    fuzzel = {
      enable = true;
      settings = {
        main = {
          font = lib.mkForce "DejaVu Sans:size=16";
        };
      };
    };

    fzf.enable = true;

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

    nushell = {
      enable = true;
      extraConfig = # nu
        ''
          $env.config = {
            show_banner: false
            edit_mode: vi
          }
        '';
      extraEnv = # nu
        ''
          $env.NH_FLAKE = "/home/spencer/Workspaces/nixos"
          $env.EDITOR = "hx"
          $env.VISUAL = "hx"
          $env.STEAM_EXTRA_COMPAT_TOOLS_PATHS = $"(''\$env.HOME)/.steam/root/compatibilitytools.d";
          $env.SSH_AUTH_SOCK = $"($env.XDG_RUNTIME_DIR)/ssh-agent"

          def rand_pw [] {
            open /dev/urandom | tr -dc r#'[:alnum:] !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~'# | head -c 32
          }
        '';
    };

    starship.enable = true;

    yazi = {
      enable = true;
      enableNushellIntegration = true;
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
          auto_update "yes"

          bind_to_address "/tmp/mpd_socket"
        '';

      musicDirectory = "/home/spencer/Music";
    };

    mpd-discord-rpc.enable = true;
    mpd-mpris.enable = true;
  };

  stylix.targets = {
    helix.enable = false;
    hyprlock.enable = false;
  };

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
