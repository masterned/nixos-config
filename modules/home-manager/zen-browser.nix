{ inputs, ... }:

{
  imports = [
    inputs.zen-browser.homeModules.twilight
  ];

  programs.zen-browser = {
    enable = true;

    policies = {
      DisableAppUpdate = true;
      DisableFirefoxAccounts = true;
      DisablePocked = true;
      DisableProfileRefresh = true;
      DisableTelemetry = true;
      DNSOverHTTPS = {
        Enabled = true;
        ProviderURL = "https://dns.quad9.net/dns-query";
        Locked = false;
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
      ExtensionsSettings = {
        "addon@darkreader.org" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/darkreader/latest.xpi";
          private_browsing = true;
        };
        "uBlock0@ramondhill.net" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          private_browsing = true;
        };
        "myallychou@gmail.com" = {
          installation_mode = "normal_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/youtube-recommended-videos/latest.xpi";
          private_browsing = true;
        };
      };
      HttpsOnlyMode = "enabled";
      NoDefaultBookmarks = true;
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
            Name = "Brave";
            URLTemplate = "https://search.brave.com/search?q=%s";
            Method = "GET";
            IconURL = "https://cdn.search.brave.com/serp/v3/_app/immutable/assets/favicon.acxxetWH.ico";
            Alias = [
              "@Brave"
              "@br"
            ];
            Description = "Brave Search";
            SuggestionURLTemplate = "https://search.brave.com/api/suggest?q=%s";
          }
          {
            Name = "Nix Packages";
            URLTemplate = "https://search.nixos.org/packages?query=%s";
            Method = "GET";
            IconURL = "https://search.nixos.org/favicon.png";
            Alias = "@np";
            Description = "NixOS Packages";
          }
          {
            Name = "Nix Options";
            URLTemplate = "https://search.nixos.org/options?query=%s";
            Method = "GET";
            IconURL = "https://search.nixos.org/favicon.png";
            Alias = "@no";
            Description = "NixOS Options";
          }
          {
            Name = "Youtube Music";
            URLTemplate = "https://music.youtube.com/search?q=%s";
            Method = "GET";
            Alias = "@ym";
            Description = "Youtube Music";
          }
        ];
        Default = "Brave";
        Remove = [
          "Google"
          "Amazon.com"
          "Bing"
          "DuckDuckGo"
          "eBay"
          "Wikipedia (en)"
        ];
      };
      UserMessaging = {
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        UrlBarInterventions = false;
        SkipOnboarding = true;
        MoreFromMozilla = false;
      };
    };
  };
}
