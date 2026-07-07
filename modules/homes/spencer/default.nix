{ inputs, self, ... }:
{
  flake = {
    homeConfigurations.spencer = inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = import inputs.nixpkgs { system = "x86_64-linux"; };
      modules = [
        self.homeModules.gnome-software
        self.homeModules.atuin
        self.homeModules.bottom
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
      ];
    };

    homeModules.spencer = { pkgs, ... }: {
      accounts.email.accounts = {
        "mr.spencerdent" = {
          enable = true;
          address = "mr.spencerdent@gmail.com";
          flavor = "gmail.com";
          imap = {
            authentication = "xoauth2";
            host = "imap.gmail.com";
            port = 993;
            tls = {
              enable = true;
              useStartTls = false;
            };
          };
          primary = true;
          realName = "Spencer Dent";
          signature = {
            showSignature = "append";
            text = ''
              --
              For Christ, for family, for mankind.
            '';
          };
          smtp = {
            authentication = "xoauth2";
            host = "smtp.gmail.com";
            port = 465;
            tls = {
              enable = true;
              useStartTls = false;
            };
          };
          thunderbird = {
            enable = true;
          };
        };
      };

      dconf = {
        enable = true;
        settings = {
          "org/gnome/desktop/interface" = {
            gtk-enable-primary-paste = true;
          };
        };
      };

      home.packages = with pkgs; [
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

        direnv = {
          enable = true;
          enableNushellIntegration = true;
          nix-direnv.enable = true;
        };

        fzf = {
          enable = true;
          historyWidget.command = "";
        };

        ghostty = {
          enable = true;
          installBatSyntax = true;
        };

        obs-studio.enable = true;

        ripgrep.enable = true;

        starship.enable = true;

        tealdeer.enable = true;

        yazi = {
          enable = true;
          enableNushellIntegration = true;
          shellWrapperName = "yy";
        };

        zoxide.enable = true;
      };

      services = {
        gpg-agent.enable = true;

        playerctld.enable = true;

        remmina.enable = true;
      };
    };
  };
}
