{ ... }: {
  flake.homeModules.email-spencer = { ... }: {
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
  };
}
