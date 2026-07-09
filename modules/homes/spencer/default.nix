{ inputs, self, ... }:
{
  flake = {
    homeConfigurations.spencer = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
      modules = [
        self.homeModules.gnome-software
        self.homeModules.atuin
        self.homeModules.bottom
        self.homeModules.direnv
        self.homeModules.ghostty
        self.homeModules.helix
        self.homeModules.imv
        self.homeModules.jujutsu
        self.homeModules.mpv
        self.homeModules.newsboat
        self.homeModules.noctalia
        self.homeModules.nushell
        self.homeModules.onlyoffice
        self.homeModules.rmpc
        self.homeModules.youtube-tui
        self.homeModules.yt-dlp
        self.homeModules.zathura
        self.homeModules.zen-browser
        self.homeModules.mpd
        self.homeModules.xdg
        self.homeModules.yazi
        self.homeModules.zellij
        {
          home = {
            username = "spencer";
            homeDirectory = "/home/spencer";
            stateVersion = "24.11";
          };
          nixpkgs.config.allowUnfree = true;
        }
        self.homeModules.spencer
        self.homeModules.stylix-spencer
        self.homeModules.email-spencer
      ];
    };

    homeModules.spencer = { pkgs, ... }: {
      dconf = {
        enable = true;
        settings = {
          "org/gnome/desktop/interface" = {
            gtk-enable-primary-paste = true;
          };
        };
      };

      home = {
        packages = with pkgs; [
          discord
          ffmpeg
          gimp3
          networkmanagerapplet
          ouch
          rustup
          signal-desktop
          tagutil
          thunderbird
          typst
          vulnix
        ];
        pointerCursor.enable = true;
      };

      programs = {
        home-manager.enable = true;

        bacon.enable = true;

        bat = {
          enable = true;
          extraPackages = with pkgs.bat-extras; [
            core
          ];
        };

        carapace = {
          enable = true;
          enableNushellIntegration = true;
        };

        fzf = {
          enable = true;
          historyWidget.command = "";
        };

        obs-studio.enable = true;

        ripgrep.enable = true;

        starship.enable = true;

        tealdeer.enable = true;

        zoxide.enable = true;
      };

      services = {
        gpg-agent.enable = true;

        playerctld.enable = true;

        remmina.enable = true;

        udiskie = {
          enable = true;
          automount = true;
          notify = true;
        };
      };
    };
  };
}
