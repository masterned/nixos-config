{
  programs.zen-browser = {
    policies.SearchEngines.Add = [
      {
        Name = "Youtube Music";
        URLTemplate = "https://music.youtube.com/search?q={searchTerms}";
        Method = "GET";
        IconURL = "https://music.youtube.com/img/favicon_144.png";
        Alias = "@ym";
        Description = "Youtube Music";
      }
    ];

    profiles.default =
      let
        containers.Personal = {
          color = "pink";
          icon = "fingerprint";
          id = 1;
        };
        pins = {
          crunchyroll = {
            id = "b375801d-d4df-4a1c-82d4-5a67e038c34d";
            container = containers.Personal.id;
            workspace = spaces.Personal.id;
            url = "https://crunchyroll.com/";
            isEssential = true;
            position = 101;
          };
          disneyplus = {
            id = "f7579689-a5b1-4c2b-948d-de5d2945c8b3";
            container = containers.Personal.id;
            workspace = spaces.Personal.id;
            url = "https://www.disneyplus.com/";
            isEssential = true;
            position = 102;
          };
        };
        spaces.Personal = {
          id = "e6f87711-e9a7-4b9a-a785-6e8a9bc01456";
          icon = "🧜🏼‍♀️";
          container = containers.Personal.id;
          position = 1000;
          theme = {
            colors = [
              {
                algorithm = "floating";
                red = 251;
                green = 217;
                blue = 217;
              }
            ];
            opacity = 1.0;
            texture = 0.0;
            type = "gradient";
          };
        };
      in
      {
        inherit containers pins spaces;
        containersForce = true;
        pinsForce = false;
        spacesForce = true;
      };
  };
}
