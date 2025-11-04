{ pkgs, ... }:
{
  home.packages = with pkgs; [
    tinymist
    vscode-langservers-extracted
  ];

  programs.helix = {
    enable = true;

    defaultEditor = true;

    languages = {
      language-server = {
        marksman = {
          command = "${pkgs.marksman}/bin/marksman";
        };
        nixd = {
          command = "${pkgs.nixd}/bin/nixd";
        };
        typos = {
          command = "${pkgs.typos-lsp}/bin/typos-lsp";
          config.diagnosticSeverity = "Info";
        };
      };
      language = [
        {
          name = "nix";
          language-servers = [ "nixd" ];
        }
        {
          name = "markdown";

          language-servers = [
            "marksman"
            "typos"
          ];
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
}
