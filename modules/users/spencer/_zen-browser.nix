{
  programs.zen-browser = {
    policies = {
      SearchEngines = {
        Add = [
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
        ];
      };
    };
    profiles.default =
      let
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
          Action1 = {
            id = "fc0094d1-403b-4d3c-8cf6-f0d86b23ecde";
            container = containers.Work.id;
            workspace = spaces.AFI.id;
            url = "https://app.action1.com/console/endpoints";
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
          Copilot = {
            id = "f240edf3-9648-493e-8bd2-9f5a03eaa5b3";
            container = containers.Work.id;
            workspace = spaces.AFI.id;
            url = "https://m365.cloud.microsoft/chat";
            isEssential = true;
            position = 203;
          };
        };
        spaces = {
          Personal = {
            id = "42c57b7b-15a7-4e00-889a-88fb5c0fa5ce";
            icon = "🧙🏻‍♂️";
            container = containers.Personal.id;
            position = 1000;
            theme = {
              colors = [
                {
                  algorithm = "floating";
                  red = 153;
                  green = 211;
                  blue = 255;
                }
              ];
              opacity = 0.5;
              texture = 0.0;
              type = "gradient";
            };
          };
          AFI = {
            id = "0ffb657b-b76a-4f3c-852a-8a20c80b1d0c";
            icon = "🧑🏻‍🔬";
            container = containers.Work.id;
            position = 2000;
            theme = {
              colors = [
                {
                  algorithm = "floating";
                  red = 196;
                  green = 20;
                  blue = 37;
                }
              ];
              opacity = 0.5;
              texture = 0.0;
              type = "gradient";
            };
          };
        };
      in
      {
        inherit containers pins spaces;
        containersForce = true;
        pinsForce = true;
        spacesForce = true;
      };
  };
}
