{ inputs, ... }: {
  flake.modules.homeManager.zen-browser = {
    imports = [ inputs.zen-browser.homeModules.twilight ];

    programs.zen-browser = {
      enable = true;

      policies = {
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
          ExcludedDomains = [ ];
          Fallback = true;
          Locked = true;
          ProviderURL = "https://dns.quad9.net/dns-query";
        };
        DontCheckDefaultBrowser = true;
        EnableTrackingProtection = {
          Value = true;
          Cryptomining = true;
          Fingerprinting = true;
          EmailTracking = true;
          Exceptions = [ ];
          Locked = false;
        };
        EncryptedMediaExtensions = {
          Enabled = false;
          Locked = false;
        };
        ExtensionSettings =
          let
            mkExtensionSettings = builtins.mapAttrs (
              _: pluginId: {
                install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
                installation_mode = "force_installed";
                private_browsing = true;
              }
            );
          in
          mkExtensionSettings {
            "addon@darkreader.org" = "darkreader";
            "uBlock0@raymondhill.net" = "ublock-origin";
            "myallychou@gmail.com" = "youtube-recommended-videos";
          };
        HttpsOnlyMode = "enabled";
        NoDefaultBookmarks = true;
        OfferToSaveLogins = true;
        Permissions.Autoplay = {
          Allow = [ ];
          Block = [ ];
          Default = "block-audio-video";
          Locked = false;
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
          Locked = true;
          MoreFromMozilla = false;
          SkipOnboarding = true;
          UrlBarInterventions = false;
        };
      };
    };

    xdg.mimeApps =
      let
        associations = builtins.listToAttrs (
          map
            (name: {
              inherit name;
              value = "zen-twilight.desktop";
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
        enable = true;

        associations.added = associations;
        defaultApplications = associations;
      };
  };
}
