{
  inputs,
  system,
  config,
  ...
}:

{
  imports = [
    inputs.zen-browser.homeModules.beta
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
    profiles = {
      "default" = {
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
        containersForce = true;
        spaces =
          let
            containers = config.programs.zen-browser.profiles."default".containers;
          in
          {
            "Personal" = {
              id = "42c57b7b-15a7-4e00-889a-88fb5c0fa5ce";
              icon = "🧙🏻‍♂️";
              container = containers."Personal".id;
              position = 1000;
              # theme.color = [
              #   {
              #     red = 153;
              #     green = 211;
              #     blue = 255;
              #   }
              # ];
            };
            "AFI" = {
              id = "0ffb657b-b76a-4f3c-852a-8a20c80b1d0c";
              icon = "🧑🏻‍🔬";
              container = containers."Work".id;
              position = 2000;
            };
          };
        spacesForce = true;
      };
    };
  };

  stylix.targets.zen-browser.profileNames = [ "default" ];

  xdg.mimeApps =
    let
      value =
        let
          zen-browser = inputs.zen-browser.packages.${system}.beta;
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
