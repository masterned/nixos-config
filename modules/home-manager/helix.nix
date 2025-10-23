{ pkgs, ... }:
{
  home.packages = with pkgs; [
    vscode-langservers-extracted
  ];

  programs.helix = {
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

      theme = "nord-night_transparent";
    };

    themes = {
      "nord-night_transparent" = {
        inherits = "nord-night";

        "ui.background" = {
          fg = "foreground";
        };
      };
    };
  };
}
