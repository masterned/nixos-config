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
      floorp-bin
      fzf
      ghostty
      gimp
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
      seahorse
      grimblast
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
      wlogout
      yt-dlp
      zathura
      zoxide
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    file = {
      ".config/ghostty/config".text = ''
          theme = nord
          background-opacity = 0.9
      '';
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
      extraConfig = ''
        $env.config = {
          show_banner: false
          edit_mode: vi
        }
      '';
      extraEnv = ''
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
    gpg-agent = {
      enable = true;
    };

    mpd = {
      enable = true;

      extraConfig = ''
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
