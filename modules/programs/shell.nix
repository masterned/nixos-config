{
  flake.modules.homeManager.shell =
    {
      pkgs,
      ...
    }:
    {
      home.shell.enableNushellIntegration = true;

      programs = {
        atuin = {
          enable = true;
          enableNushellIntegration = true;
          settings = {
            auto_sync = false;
            update_check = false;
          };
        };

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

        nushell = {
          enable = true;
          extraConfig = # nu
            ''
              $env.config = {
                show_banner: false
                edit_mode: 'vi'
              }
            '';
        };

        ripgrep.enable = true;

        starship.enable = true;

        tealdeer.enable = true;

        yazi = {
          enable = true;
          enableNushellIntegration = true;
          shellWrapperName = "yy";
        };

        zellij.enable = true;

        zoxide.enable = true;
      };
    };
}
