{
  inputs,
  system,
  ...
}:

{
  imports = [
    inputs.zen-browser.homeModules.twilight
  ];

  programs.zen-browser = {
    enable = true;

    policies =
      let
        mkExtensionSettings = builtins.mapAttrs (
          _: pluginId: {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
            installation_mode = "force_installed";
            private_browsing = true;
          }
        );
      in
      {
        AutofillAddressEnabled = true;
        AutofillCreditCardEnabled = true;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxAccounts = true;
        DisableFirefoxStudies = true;
        DisablePocket = true;
        DisableProfileRefresh = true;
        DisableTelemetry = true;
        DNSOverHTTPS = {
          Enabled = true;
          ProviderURL = "https://dns.quad9.net/dns-query";
          Locked = true;
          ExcludedDomains = [ ];
          Fallback = true;
        };
        DontCheckDefaultBrowser = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = false;
          Cryptomining = true;
          Fingerprinting = true;
          EmailTracking = true;
          Exceptions = [ ];
        };
        EncryptedMediaExtensions = {
          Enabled = false;
          Locked = false;
        };
        ExtensionSettings = mkExtensionSettings {
          "addon@darkreader.org" = "darkreader";
          "uBlock0@raymondhill.net" = "ublock-origin";
          "myallychou@gmail.com" = "youtube-recommended-videos";
        };
        HttpsOnlyMode = "enabled";
        NoDefaultBookmarks = true;
        OfferToSaveLogins = true;
        Permissions = {
          Autoplay = {
            Allow = [ ];
            Block = [ ];
            Default = "block-audio-video";
            Locked = false;
          };
        };
        PromptForDownloadLocation = true;
        SearchEngines = {
          Add = [
            {
              Name = "StartPage";
              URLTemplate = "https://www.startpage.com/sp/search?q={searchTerms}";
              Method = "GET";
              IconURL = "https://www.startpage.com/sp/cdn/favicons/favicon-gradient.ico";
              Alias = "@st";
              Description = "StartPage";
              SuggestURLTemplate = "https://www.startpage.com/osuggestions?q={searchTerms}";
            }
            {
              Name = "Brave";
              URLTemplate = "https://search.brave.com/search?q={searchTerms}";
              Method = "GET";
              IconURL = "https://cdn.search.brave.com/serp/v3/_app/immutable/assets/favicon.acxxetWH.ico";
              Alias = "@br";
              Description = "Brave Search";
              SuggestURLTemplate = "https://search.brave.com/api/suggest?q=%s";
            }
            {
              Name = "Nix Packages";
              URLTemplate = "https://search.nixos.org/packages?query={searchTerms}";
              Method = "GET";
              IconURL = "https://search.nixos.org/favicon-96x96.png";
              Alias = "@np";
              Description = "NixOS Packages";
            }
            {
              Name = "Nix Options";
              URLTemplate = "https://search.nixos.org/options?query={searchTerms}";
              Method = "GET";
              IconURL = "https://search.nixos.org/favicon-96x96.png";
              Alias = "@no";
              Description = "NixOS Options";
            }
            {
              Name = "Youtube Music";
              URLTemplate = "https://music.youtube.com/search?q={searchTerms}";
              Method = "GET";
              IconURL = "https://music.youtube.com/img/favicon_144.png";
              Alias = "@ym";
              Description = "Youtube Music";
            }
          ];
          Default = "StartPage";
          Remove = [
            "Google"
            "Amazon.com"
            "Bing"
            "DuckDuckGo"
            "eBay"
            "Wikipedia (en)"
          ];
        };
        SearchSuggestEnabled = false;
        ShowHomeButton = false;
        UserMessaging = {
          ExtensionRecommendations = false;
          FeatureRecommendations = false;
          UrlBarInterventions = false;
          SkipOnboarding = true;
          MoreFromMozilla = false;
          Locked = true;
        };
      };
    profiles.default = let
      containers = {
        Personal = {
          color = "blue";
          icon = "fingerprint";
          id = 1;
        };
        Work = {
          color = "red";
          icon = "briefcase";
          id = 2;
        };
      };
      pins = {
        Monkeytype = {
          id = "1d6e72f6-d7a9-4dc0-9357-bade6592e616";
          container = containers.Personal.id;
          workspace = spaces.Personal.id;
          url = "https://monkeytype.com/";
          isEssential = true;
          position = 101;
        };
        "GitHub masterned" = {
          id = "40474dc3-dbfe-42df-b43a-046febedfc97";
          container = containers.Personal.id;
          workspace = spaces.Personal.id;
          url = "https://github.com/masterned";
          isEssential = true;
          position = 102;
        };
        ChatGPT = {
          id = "89b940c8-5343-4bd5-ad20-3c4ee72f5387";
          container = containers.Personal.id;
          workspace = spaces.Personal.id;
          url = "https://chatgpt.com/";
          isEssential = true;
          position = 103;
        };
        "Microsoft Teams" = {
          id = "c836823f-cd49-4448-adab-ab0f262425b3";
          container = containers.Work.id;
          workspace = spaces.AFI.id;
          url = "https://teams.cloud.microsoft/";
          isEssential = true;
          position = 101;
        };
        Outlook = {
          id = "5cc2f689-abd8-42ed-bd44-823e49d5d060";
          container = containers.Work.id;
          workspace = spaces.AFI.id;
          url = "https://outlook.cloud.microsoft/mail/";
          isEssential = true;
          position = 102;
        };
        spiceworks = {
          id = "10a0dadc-a4b7-455a-a124-906dfe4c4354";
          container = containers.Work.id;
          workspace = spaces.AFI.id;
          url = "https://on.spiceworks.com/tickets/open/1";
          isEssential = true;
          position = 103;
        };
        "Ops Meeting Notes" = {
          id = "1a659460-cd94-4c12-aa9c-bea2be3e0187";
          container = containers.Work.id;
          workspace = spaces.AFI.id;
          url = "https://aromaticfragrancesintl-my.sharepoint.com/:w:/r/personal/spencer_afi-usa_com/_layouts/15/doc2.aspx?sourcedoc={EE8DFD07-A35C-494C-ACAF-568ABA310F61}&file=Document.docx&action=editnew&mobileredirect=true&wdPreviousSession=710e5b0c-0e41-e93f-0553-73e1911c86ba&wdNewAndOpenCt=1768311122471&wdo=4&wdOrigin=wacFileNew&wdPreviousCorrelation=1d78fb98-ec02-4277-8917-85dd8da29407&wdnd=1";
          isEssential = true;
          position = 201;
        };
        OneDrive = {
          id = "778df7c0-b0e3-437a-af2e-f01e453e9f32";
          container = containers.Work.id;
          workspace = spaces.AFI.id;
          url = "https://aromaticfragrancesintl-my.sharepoint.com/shared";
          isEssential = true;
          position = 202;
        };
      };
      spaces =
        {
          Personal = {
            id = "42c57b7b-15a7-4e00-889a-88fb5c0fa5ce";
            icon = "🧙🏻‍♂️";
            container = containers.Personal.id;
            position = 1000;
          };
          AFI = {
            id = "0ffb657b-b76a-4f3c-852a-8a20c80b1d0c";
            icon = "🧑🏻‍🔬";
            container = containers.Work.id;
            position = 2000;
          };
        };
    in {
      containersForce = true;
      pinsForce = true;
      spacesForce = true;
      inherit containers pins spaces;
    };
    suppressXdgMigrationWarning = true;
  };

  stylix.targets.zen-browser.profileNames = [ "default" ];

  xdg.mimeApps =
    let
      value =
        let
          zen-browser = inputs.zen-browser.packages.${system}.twilight;
        in
        zen-browser.meta.desktopFileName;

      associations = builtins.listToAttrs (
        map
          (name: {
            inherit name value;
          })
          [
            "application/x-extension-shtml"
            "application/x-extension-xhtml"
            "application/x-extension-html"
            "application/x-extension-xht"
            "application/x-extension-htm"
            "x-scheme-handler/unknown"
            "x-scheme-handler/mailto"
            "x-scheme-handler/chrome"
            "x-scheme-handler/about"
            "x-scheme-handler/https"
            "x-scheme-handler/http"
            "application/xhtml+xml"
            "application/json"
            "text/plain"
            "text/html"
          ]
      );
    in
    {
      associations.added = associations;
      defaultApplications = associations;
    };
}
