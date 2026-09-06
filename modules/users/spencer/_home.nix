let
  username = "spencer";
  homeDirectory = "/home/spencer";
  flake = "${homeDirectory}/Projects/nixos";
in
{
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

      thunderbird.enable = true;
    };
  };

  home = {
    inherit username homeDirectory;
    sessionVariables.NH_FLAKE = flake;
    stateVersion = "24.11";
  };

  programs = {
    home-manager.enable = true;

    helix.languages.language-server.nixd.config.nixd =
      let
        flakeExpr = ''(builtins.getFlake "${flake}")'';
      in
      {
        nixpkgs.expr = "import ${flakeExpr}.inputs.nixpkgs { }";
        options = {
          flake-parts.expr = "${flakeExpr}.debug.options";
          home-manager.expr = ''${flakeExpr}.homeConfigurations."${username}@cygnus".options'';
          nixos.expr = "${flakeExpr}.nixosConfigurations.cygnus.options";
        };
      };

    jujutsu.settings.user = {
      name = "Spencer Dent";
      email = "mr.spencerdent@gmail.com";
    };

    ssh.settings = {
      "github.com" = {
        HostName = "github.com";
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/masterned_github";
        User = "masterned";
      };
      diakonos = {
        HostName = "10.0.0.2";
        Port = 22;
        User = "cygnus";
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/diakonos";
      };
      ambroxan = {
        HostName = "10.57.50.227";
        Port = 22;
        User = "afi-spencerd";
        IdentitiesOnly = true;
        IdentityFile = "~/.ssh/ambroxan";
      };
    };
  };

  # stylix.image = pkgs.fetchurl {
  #   url = "http://cygnus.home.arpa/neo_EPCOT.jpg";
  #   sha256 = "sha256-XO9mAGBTR2gpzKASPxNEZF3BHuoZ//b4ZIKwBvPKlsA=";
  # };
}
