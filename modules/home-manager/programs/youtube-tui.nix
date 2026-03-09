{ pkgs, ... }:
{
  home = {
    file =
      let
        ymlFormat = pkgs.formats.yaml { };
      in
      {
        ".config/youtube-tui/appearance.yml".source = ymlFormat.generate "appearance.yml" {
          borders = "Rounded";
          colors = {
            text = "Reset";
            text_special = "Reset";
            text_secondary = "Reset";
            text_error = "LightRed";
            outline = "Reset";
            outline_selected = "LightBlue";
            outline_hover = "LightRed";
            outline_secondary = "LightYellow";
            message_outline = "#FF7F00";
            message_error_outline = "LightRed";
            message_success_outline = "LightGreen";
            command_capture = "#64FF64";
            item_info = {
              tag = "Gray";
              title = "LightBlue";
              description = "Gray";
              author = "LightGreen";
              viewcount = "LightYellow";
              length = "LightCyan";
              published = "LightMagenta";
              video_count = "#838DFF";
              sub_count = "#65FFBA";
              likes = "#C8FF81";
              genre = "#FF75D7";
              page_turner = "Gray";
            };
          };
        };
        ".config/youtube-tui/cmdefine.yml".source = ymlFormat.generate "cmdefine.yml" {
          q = "quit";
          video = "loadpage video";
          playlist = "loadpage playlist";
          v = "version";
          print = "echo";
          next = "mpv playlist-next ;; echo mpv Skipped";
          back = "mpv playlist-previous ;; echo mpv Skipped";
          pause = "mpv sprop pause yes ;; echo mpv Player paused";
          popular = "loadpage popular";
          watchhistory = "loadpage watchhistory";
          h = "help";
          cp = "copy";
          sub = "sync";
          channel = "loadpage channel";
          search = "loadpage search";
          library = "loadpage library";
          feed = "loadpage feed";
          trending = "loadpage trending";
          r = "reload";
          tpause = "mpv tprop pause ;; echo success Toggled player pause";
          exit = "quit";
          resume = "mpv sprop pause no ;; echo mpv Player resumed";
          bookmarks = "loadpage bookmarks";
          x = "quit";
          rc = "reload configs";
        };
        ".config/youtube-tui/commandbindings.yml".text = # yaml
          ''
            global:
              'f':
                2: run ''${browser} ''\'''${url}'
              ' ':
                0: tpause ;; echo mpv Player pause toggled
              Right:
                3: next ;; echo mpv Skipped
                2: mpv seek 5 ;; echo mpv Fast forwarded 5 seconds
              'c':
                2: cp ''${url}
              Left:
                2: mpv seek -5 ;; echo mpv Rewinded 5 seconds
                3: back ;; echo mpv Unskipped
              'y':
                0: cp ''${url}
            search:
              'p':
                2: parrun mpv ''\'''${hover-url}'
              'a':
                2: parrun ''${terminal-emulator} mpv ''\'''${hover-url}' --no-video
              'A':
                1: parrun ''${terminal-emulator} mpv ''\'''${hover-url}' --no-video --loop-playlist=inf --shuffle
            popular:
              'a':
                2: parrun ''${terminal-emulator} mpv ''\'''${hover-url}' --no-video
              'p':
                2: parrun mpv ''\'''${hover-url}'
              'A':
                1: parrun ''${terminal-emulator} mpv ''\'''${hover-url}' --no-video --loop-playlist=inf --shuffle
            trending:
              'p':
                2: parrun mpv ''\'''${hover-url}'
              'a':
                2: parrun ''${terminal-emulator} mpv ''\'''${hover-url}' --no-video
              'A':
                1: parrun ''${terminal-emulator} mpv ''\'''${hover-url}' --no-video --loop-playlist=inf --shuffle
            video: {}
            playlist:
              'a':
                2: parrun ''${terminal-emulator} mpv ''\'''${hover-url}' --no-video
              'A':
                1: parrun ''${terminal-emulator} mpv ''\'''${hover-url}' --no-video --loop-playlist=inf --shuffle
              'p':
                2: parrun mpv ''\'''${hover-url}'
            channel_main: {}
            channel_videos:
              'A':
                1: parrun ''${terminal-emulator} mpv ''\'''${hover-url}' --no-video --loop-playlist=inf --shuffle
              'a':
                2: parrun ''${terminal-emulator} mpv ''\'''${hover-url}' --no-video
              'p':
                2: parrun mpv ''\'''${hover-url}'
            channel_playlists:
              'a':
                2: parrun ''${terminal-emulator} mpv ''\'''${hover-url}' --no-video
              'A':
                1: parrun ''${terminal-emulator} mpv ''\'''${hover-url}' --no-video --loop-playlist=inf --shuffle
              'p':
                2: parrun mpv ''\'''${hover-url}'
            watchhistory:
              'p':
                2: parrun mpv ''\'''${hover-url}'
              'A':
                1: parrun ''${terminal-emulator} mpv ''\'''${hover-url}' --no-video --loop-playlist=inf --shuffle
              'a':
                2: parrun ''${terminal-emulator} mpv ''\'''${hover-url}' --no-video
            feed:
              'A':
                1: parrun ''${terminal-emulator} mpv ''\'''${hover-channel-url}/videos' --no-video --loop-playlist=inf --shuffle
              'P':
                1: parrun ''${terminal-emulator} mpv ''\'''${hover-channel-url}/videos' --no-video --loop-playlist=inf --shuffle
              'p':
                2: parrun mpv ''\'''${hover-video-url}'
              'a':
                2: parrun ''${terminal-emulator} mpv ''\'''${hover-video-url}' --no-video
            library:
              'p':
                2: parrun mpv ''\'''${hover-url}'
              'a':
                2: parrun ''${terminal-emulator} mpv ''\'''${hover-url}' --no-video
              'A':
                1: parrun ''${terminal-emulator} mpv ''\'''${hover-url}' --no-video --loop-playlist=inf --shuffle
          '';
        ".config/youtube-tui/commands.yml".source = ymlFormat.generate "commands.yml" {
          launch_command = "loadpage library ;; flush ;; history clear ;; key Esc 0 ;; key Up 0 ;; key Up 0 ;; key Left 0 ;; key Enter 0";
          video = [
            { "Reload updated video" = "run rm '~/.cache/youtube-tui/info/\${id}.json' ;; video \${id}"; }
            { "Play video" = "parrun \${video-player} '\${embed-url}'"; }
            {
              "Play audio" =
                "mpv stop ;; resume ;; mpv sprop loop-file no ;; mpv loadfile '\${embed-url}' ;; echo mpv Player started";
            }
            {
              "Play audio (loop)" =
                "mpv stop ;; resume ;; mpv sprop loop-file inf ;; mpv loadfile '\${embed-url}' ;; echo mpv Player started";
            }
            { "View channel" = "channel \${channel-id}"; }
            { "Subscribe to channel" = "sync \${channel-id}"; }
            { "Open in browser" = "parrun \${browser} '\${url}'"; }
            { "Toggle bookmark" = "togglemark \${id}"; }
            {
              "Save video to library" =
                "bookmark \${id} ;; run rm -rf '\${save-path}\${id}.*' ;; parrun \${terminal-emulator} \${youtube-downloader} '\${embed-url}' -o '\${save-path}%(title)s[%(id)s].%(ext)s'";
            }
            {
              "Save audio to library" =
                "bookmark \${id} ;; parrun rm -rf '\${save-path}\${id}.*' ;; parrun \${terminal-emulator} \${youtube-downloader} '\${embed-url}' -x -o '\${save-path}%(title)s[%(id)s].%(ext)s'";
            }
            { "Mode: \${provider}" = "switchprovider"; }
          ];
          saved_video = [
            { "Reload updated video" = "run rm '~/.cache/youtube-tui/info/\${id}.json' ;; video \${id}"; }
            { "[Offline] Play saved file" = "parrun \${video-player} '\${offline-path}' --force-window"; }
            {
              "[Offline] Play saved file (audio)" =
                "mpv stop ;; resume ;; mpv sprop loop-file no ;; mpv loadfile '\${offline-path}' ;; echo mpv Player started";
            }
            {
              "[Offline] Play saved file (audio loop)" =
                "mpv stop ;; resume ;; mpv sprop loop-file inf ;; mpv loadfile '\${offline-path}' ;; echo mpv player started";
            }
            { "View channel" = "channel \${channel-id}"; }
            { "Subscribe to channel" = "sync \${channel-id}"; }
            { "Open in browser" = "parrun \${browser} '\${url}'"; }
            { "Toggle bookmark" = "togglemark \${id}"; }
            {
              "Redownload video to library" =
                "bookmark \${id} ;; run rm \${save-path}*\${id}*.* ;; parrun \${terminal-emulator} \${youtube-downloader} \${embed-url} -o '\${save-path}%(title)s[%(id)s].%(ext)s'";
            }
            {
              "Redownload audio to library" =
                "bookmark \${id} ;; run rm \${save-path}*\${id}*.* ;; parrun \${terminal-emulator} \${youtube-downloader} \${embed-url} -x -o '\${save-path}%(title)s[%(id)s].%(ext)s'";
            }
            { "Delete saved file" = "run rm \${save-path}*\${id}*.*"; }
          ];
          playlist = [
            { "Switch view" = "%switch-view%"; }
            { "Reload updated playlist" = "run rm ~/.cache/youtube-tui/info/\${id}.json ;; reload"; }
            { "Play all (videos)" = "parrun \${video-player} \${url}"; }
            {
              "Play all (audio)" =
                "mpv stop ;; resume ;; \${mpv-queuelist} ;; mpv sprop loop-playlist no ;; mpv playlist-play-index 0 ;; echo mpv Player started";
            }
            {
              "Shuffle play all (audio loop)" =
                "mpv stop ;; resume ;; \${mpv-queuelist} ;; mpv sprop loop-playlist yes ;; mpv playlist-shuffle ;; mpv playlist-play-index 0 ;; echo mpv Player started";
            }
            { "View channel" = "channel \${channel-id}"; }
            { "Subscribe to channel" = "sync \${channel-id}"; }
            { "Open in browser" = "parrun \${browser} '\${url}'"; }
            { "Toggle bookmark" = "togglemark \${id}"; }
            {
              "Save playlist videos to library" =
                "bookmark \${id} ;; run rm -rf '\${save-path}*\${id}*' ;; parrun \${terminal-emulator} bash -c \"\${youtube-downloader} \${all-videos} -o '\"'\${save-path}\${title}[\${id}]/%(title)s[%(id)s].%(ext)s'\"'\"";
            }
            {
              "Save playlist audio to library" =
                "bookmark \${id} ;; run rm -rf '\${save-path}*\${id}*' ;; parrun \${terminal-emulator} bash -c \"\${youtube-downloader} \${all-videos} -x -o '\"'\${save-path}\${title}[\${id}]/%(title)s[%(id)s].%(ext)s'\"'\"";
            }
            { "Mode: \${provider}" = "switchprovider"; }
          ];
          saved_playlist = [
            { "Switch view" = "%switch-view%"; }
            { "Reload updated playlist" = "run rm ~/.cache/youtube-tui/info/\${id}.json ;; reload"; }
            {
              "[Offline] Play all (videos)" = "parrun \${video-player} \${save-path}*\${id}*/* --force-window";
            }
            {
              "[Offline] Play all (audio)" =
                "mpv stop ;; resume ;; \${offline-queuelist} ;; mpv sprop loop-playlist no ;; mpv playlist-play-index 0 ;; echo mpv Player started";
            }
            {
              "[Offline] Shuffle play all (audio loop)" =
                "mpv stop ;; resume ;; \${offline-queuelist} ;; mpv sprop loop-playlist yes ;; mpv playlist-shuffle ;; mpv playlist-play-index 0 ;; echo mpv Player started";
            }
            { "View channel" = "channel \${channel-id}"; }
            { "Subscribe to channel" = "sync \${channel-id}"; }
            { "Open in browser" = "parrun \${browser} '\${url}'"; }
            { "Toggle bookmark" = "togglemark \${id}"; }
            {
              "Redownload playlist videos to library" =
                "bookmark \${id} ;; run rm -rf \${save-path}*\${id}* ;; parrun \${terminal-emulator} bash -c \"\${youtube-downloader} \${all-videos} -o '\"'\${save-path}\${title}[\${id}]/%(title)s[%(id)s].%(ext)s'\"'\"";
            }
            {
              "Redownload playlist audio to library" =
                "bookmark \${id} ;; run rm -rf \${save-path}*\${id}* ;; parrun \${terminal-emulator} bash -c \"\${youtube-downloader} \${all-videos} -x -o '\"'\${save-path}\${title}[\${id}]/%(title)s[%(id)s].%(ext)s'\"'\"";
            }
            { "Delete saved files" = "run rm -rf \${save-path}*\${id}*"; }
          ];
          channel = [
            { "Subscribe to channel" = "sync \${id}"; }
            { "Play all (videos)" = "parrun \${video-player} \${url}"; }
            {
              "Play all (audio)" =
                "mpv stop ;; resume ;; mpv loadfile \${url} ;; mpv sprop loop-playlist no ;; mpv playlist-play-index 0 ;; echo mpv Player started";
            }
            {
              "Shuffle play all (audio loop)" =
                "mpv stop ;; resume ;; mpv loadfile \${url} ;; mpv sprop loop-playlist yes ;; mpv playlist-shuffle ;; mpv playlist-play-index 0 ;; echo mpv Player started";
            }
          ];
        };
        ".config/youtube-tui/keybindings.yml".text = # yaml
          ''
            'w':
              2: RemoveWord
            'd':
              4: RemoveWord
              0: ClearHistory
            'e':
              2: End
            'h':
              0: MoveLeft
            Home:
              0: FirstHistory
            'j':
              0: MoveDown
            'u':
              2: ClearLine
            Left:
              2: PreviousWord
              4: Back
              0: MoveLeft
            'a':
              2: First
            End:
              0: ClearHistory
            'l':
              0: MoveRight
            Up:
              2: PreviousEntry
              0: MoveUp
            Esc:
              0: Deselect
            'v':
              2: Paste
            ':':
              0: StartCommandCapture
            'r':
              2: Reload
            'q':
              0: Exit
            'k':
              0: MoveUp
            F5:
              0: Reload
            Down:
              0: MoveDown
              2: NextEntry
            Backspace:
              0: Back
            Right:
              2: NextWord
              0: MoveRight
            Enter:
              0: Select
          '';
        ".config/youtube-tui/main.yml".source = ymlFormat.generate "main.yml" {
          mouse_support = true;
          invidious_instance = "https://invidious.f5.si";
          write_config = "Try";
          allow_unicode = true;
          message_bar_default = "All good =)";
          images = "Sixels";
          refresh_after_modifying_search_filters = true;
          syncing = {
            download_images = true;
            sync_channel_info = true;
            sync_channel_cooldown_secs = 86400;
            sync_videos_cooldown_secs = 600;

          };
          limits = {
            watch_history = 50;
            search_history = 75;
            commands_history = 75;

          };
          textbar_scroll_behaviour = "History";
          image_index = 4;
          provider = "YouTube";
          search_provider = "RustyPipe";
          api_key = "YOUR API KEY HERE";
          shell = "sh";
          legacy_input_handling = false;
          env = {
            youtube-downloader = "yt-dlp";
            download-path = "~/Downloads/%(title)s-%(id)s.%(ext)s";
            save-path = "~/.local/share/youtube-tui/saved/";
            video-player = "mpv";
            terminal-emulator = "ghostty -e";
            browser = "xdg-open";
          };
        };
        ".config/youtube-tui/pages.yml".text = # yaml
          ''
            main_menu:
              layout:
              - type: NonCenteredRow
                items:
                - SearchBar
                - SearchFilters
              - type: CenteredRow
                items:
                - Library
                - Feed
                - History
              - type: NonCenteredRow
                items:
                - ItemList
              - type: NonCenteredRow
                items:
                - MessageBar
              message: Loading main menu...
              command: key Esc 0 ;; key Down 0 ;; key Down 0 ;; key Enter 0
            feed:
              layout:
              - type: NonCenteredRow
                items:
                - SearchBar
                - SearchFilters
              - type: CenteredRow
                items:
                - Library
                - Feed
                - History
              - type: NonCenteredRow
                items:
                - ChannelList
              - type: NonCenteredRow
                items:
                - VideoList
              - type: NonCenteredRow
                items:
                - MessageBar
              message: Loading feed...
              command: key Esc 0 ;; key Down 0 ;; key Down 0 ;; key Enter 0
            search:
              layout:
              - type: NonCenteredRow
                items:
                - SearchBar
                - SearchFilters
              - type: NonCenteredRow
                items:
                - ItemList
              - type: NonCenteredRow
                items:
                - MessageBar
              message: Loading search results...
              command: key Esc 0 ;; key Down 0 ;; key Enter 0
            singleitem:
              layout:
              - type: NonCenteredRow
                items:
                - SearchBar
                - SearchFilters
              - type: NonCenteredRow
                items:
                - SingleItemInfo
              - type: NonCenteredRow
                items:
                - MessageBar
              message: Loading item details...
              command: key Esc 0 ;; key Down 0 ;; key Enter 0
            channeldisplay:
              layout:
              - type: NonCenteredRow
                items:
                - SearchBar
                - SearchFilters
              - type: CenteredRow
                items:
                - ChannelMain
                - ChannelVideos
                - ChannelPlaylists
              - type: NonCenteredRow
                items:
                - ChannelDisplay
              - type: NonCenteredRow
                items:
                - MessageBar
              message: Loading channel details...
              command: key Esc 0 ;; key Down 0 ;; key Enter 0 ;; key Up 0
          '';
        ".config/youtube-tui/remaps.yml".text = # yaml
          ''
            'a':
              5:
                code: 'b'
                modifiers: 5
          '';
        ".config/youtube-tui/search.yml".source = ymlFormat.generate "search.tml" {
          query = "";
          filters = {
            sort = "Relevance";
            date = "None";
            duration = "None";
            type = "All";
          };
          page = 1;
        };
      };
    packages = [ pkgs.youtube-tui ];
  };
}
