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
      floorp
      fzf
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
      remmina
      ripgrep
      rmpc
      rustup
      signal-desktop
      taskwarrior3
      tiled
      thunderbird
      wlogout
      yt-dlp
      zathura
      zoxide
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
    file = {
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
    sessionVariables = {
      # EDITOR = "emacs";
    };

    shell.enableNushellIntegration = true;

  };

  dconf = {
    enable = true;
    settings = { };
  };

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;

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

        def rand_pw [] {
          open /dev/urandom | tr -dc r#'[:alnum:] !"#$%&'()*+,-./:;<=>?@[\]^_`{|}~'# | head -c 32
        }
      '';
    };

    rmpc = {
      enable = true;
      config = ''
        #![enable(implicit_some)]
        #![enable(unwrap_newtypes)]
        #![enable(unwrap_variant_newtypes)]
        (
            address: "/tmp/mpd_socket",
            password: None,
            theme: None,
            cache_dir: Some("/tmp/rmpc/cache"),
            lyrics_dir: Some("/home/spencer/.cache/rmpc/lyrics"),
            on_song_change: None,
            volume_step: 5,
            max_fps: 30,
            scrolloff: 0,
            wrap_navigation: false,
            enable_mouse: true,
            status_update_interval_ms: 1000,
            select_current_song_on_change: false,
            album_art: (
                method: Auto,
                max_size_px: (width: 1200, height: 1200),
                disabled_protocols: ["http://", "https://"],
                vertical_align: Center,
                horizontal_align: Center,
            ),
            keybinds: (
                global: {
                    ":":       CommandMode,
                    ",":       VolumeDown,
                    "s":       Stop,
                    ".":       VolumeUp,
                    "<Tab>":   NextTab,
                    "<S-Tab>": PreviousTab,
                    "1":       SwitchToTab("Queue"),
                    "2":       SwitchToTab("Directories"),
                    "3":       SwitchToTab("Artists"),
                    "4":       SwitchToTab("Album Artists"),
                    "5":       SwitchToTab("Albums"),
                    "6":       SwitchToTab("Playlists"),
                    "7":       SwitchToTab("Search"),
                    "q":       Quit,
                    ">":       NextTrack,
                    "p":       TogglePause,
                    "<":       PreviousTrack,
                    "f":       SeekForward,
                    "z":       ToggleRepeat,
                    "x":       ToggleRandom,
                    "c":       ToggleConsume,
                    "v":       ToggleSingle,
                    "b":       SeekBack,
                    "~":       ShowHelp,
                    "I":       ShowCurrentSongInfo,
                    "O":       ShowOutputs,
                    "P":       ShowDecoders,
                },
                navigation: {
                    "k":         Up,
                    "j":         Down,
                    "h":         Left,
                    "l":         Right,
                    "<Up>":      Up,
                    "<Down>":    Down,
                    "<Left>":    Left,
                    "<Right>":   Right,
                    "<C-k>":     PaneUp,
                    "<C-j>":     PaneDown,
                    "<C-h>":     PaneLeft,
                    "<C-l>":     PaneRight,
                    "<C-u>":     UpHalf,
                    "N":         PreviousResult,
                    "a":         Add,
                    "A":         AddAll,
                    "r":         Rename,
                    "n":         NextResult,
                    "g":         Top,
                    "<Space>":   Select,
                    "<C-Space>": InvertSelection,
                    "G":         Bottom,
                    "<CR>":      Confirm,
                    "i":         FocusInput,
                    "J":         MoveDown,
                    "<C-d>":     DownHalf,
                    "/":         EnterSearch,
                    "<C-c>":     Close,
                    "<Esc>":     Close,
                    "K":         MoveUp,
                    "D":         Delete,
                },
                queue: {
                    "D":       DeleteAll,
                    "<CR>":    Play,
                    "<C-s>":   Save,
                    "a":       AddToPlaylist,
                    "d":       Delete,
                    "i":       ShowInfo,
                    "C":       JumpToCurrent,
                },
            ),
            search: (
                case_sensitive: false,
                mode: Contains,
                tags: [
                    (value: "any",         label: "Any Tag"),
                    (value: "artist",      label: "Artist"),
                    (value: "album",       label: "Album"),
                    (value: "albumartist", label: "Album Artist"),
                    (value: "title",       label: "Title"),
                    (value: "filename",    label: "Filename"),
                    (value: "genre",       label: "Genre"),
                ],
            ),
            artists: (
                album_display_mode: SplitByDate,
                album_sort_by: Date,
            ),
            tabs: [
                (
                    name: "Queue",
                    pane: Split(
                        direction: Horizontal,
                        panes: [(size: "40%", pane: Pane(AlbumArt)), (size: "60%", pane: Pane(Queue))],
                    ),
                ),
                (
                    name: "Directories",
                    pane: Pane(Directories),
                ),
                (
                    name: "Artists",
                    pane: Pane(Artists),
                ),
                (
                    name: "Album Artists",
                    pane: Pane(AlbumArtists),
                ),
                (
                    name: "Albums",
                    pane: Pane(Albums),
                ),
                (
                    name: "Playlists",
                    pane: Pane(Playlists),
                ),
                (
                    name: "Search",
                    pane: Pane(Search),
                ),
            ],
        )
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

          modules-left = [
            "hyprland/workspaces"
          ];
          modules-center = [
            "mpd"
            "clock"
          ];
          modules-right = [
            "network"
            "backlight"
            "wireplumber"
            "battery"
            "custom/power"
          ];

          backlight = {
            "format" = "{percent}% {icon}";
            "format-icons" = [
              ""
              ""
            ];
          };

          battery = {
            "interval" = 60;
            "states" = {
              "warning" = 30;
              "critical" = 15;
            };
            "format" = "{capacity}% {icon}";
            "format-icons" = [
              ""
              ""
              ""
              ""
              ""
            ];
            "max-length" = 25;
          };

          clock = {
            interval = 1;
            format = "{:%Y-%m-%d %H:%M:%S}";
          };

          "custom/power" = {
            "format" = " ⏻ ";
            tooltip = false;
            "on-click" = "${pkgs.wlogout}/bin/wlogout -p layer-shell";
          };

          network = {
            "format-wifi" = "{essid} ({signalStrength}%) ";
            "format-ethernet" = "{ipadder}/{cidr} ";
          };

          wireplumber = {
            format = "{volume}% {icon}";
            "format-muted" = "";
            "on-click" = "${pkgs.pavucontrol}/bin/pavucontrol";
            "format-icons" = [
              ""
              ""
              ""
            ];
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

        bind_to_address "/tmp/mpd_socket"
      '';

      musicDirectory = "/home/spencer/Music";
    };

    mpd-discord-rpc.enable = true;
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
