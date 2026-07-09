{ ... }: {
  flake.homeModules.helix =
    { pkgs, ... }:
    {
      programs.helix = {
        enable = true;

        defaultEditor = true;

        extraPackages = with pkgs; [
          lldb
          nixfmt
          rust-analyzer
          tinymist
          vscode-langservers-extracted
        ];

        languages = {
          language-server = {
            marksman = {
              command = "${pkgs.marksman}/bin/marksman";
            };
            nixd = {
              command = "${pkgs.nixd}/bin/nixd";
              config.nixd =
                let
                  hostname = "cygnus";
                  username = "spencer";
                  nixFlake = "(builtins.getFlake (toString /home/${username}/Workspaces/nixos))";
                in
                {
                  formatting.command = [ "nixfmt" ];
                  nixpkgs.expr = "import ${nixFlake}.inputs.nixpkgs { }";
                  options = {
                    nixos.expr = ''${nixFlake}.nixosConfigurations."${hostname}".options'';
                    home-manager.expr = ''${nixFlake}.homeConfigurations."${username}".options'';
                  };
                };
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
    };
}
