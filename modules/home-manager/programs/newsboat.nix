{ pkgs, ... }:
{
  programs.newsboat = {
    enable = true;

    extraConfig = /* config */ ''
      macro v set browser "mpv %u" ; open-in-browser ; set browser "${pkgs.xdg-utils}/bin/xdg-open"

      # unbind keys
      unbind-key ENTER
      unbind-key j
      unbind-key k
      unbind-key J
      unbind-key K

      # bind keys - vim inspired
      bind-key j down
      bind-key k up
      bind-key l open
      bind-key h quit
    '';

    urls =
      let
        yt_url = cid: "https://www.youtube.com/feeds/videos.xml?channel_id=${cid}";
      in
      [
        {
          title = "Bardic Aggravation";
          tags = [
            "dc20"
            "ttrpgs"
            "youtube"
          ];
          url = yt_url "UCg7JrN8jLxzSX8Te3NRldNA";
        }
        {
          title = "Brodie Robertson";
          tags = [
            "linux"
            "youtube"
          ];
          url = yt_url "UCld68syR8Wi-GY_n4CaoJGA";
        }
        {
          title = "chris biscardi";
          tags = [
            "bevy"
            "rust"
            "game-development"
            "youtube"
          ];
          url = yt_url "UCiSIL42pQRpc-8JNiYDFyzQ";
        }
        {
          title = "Code to the Moon";
          tags = [
            "rust"
            "software-development"
            "youtube"
          ];
          url = yt_url "UCjREVt2ZJU8ql-NC9Gu-TJw";
        }
        {
          title = "CodeAesthetic";
          tags = [
            "software-development"
            "youtube"
          ];
          url = yt_url "UCaSCt8s_4nfkRglWCvNSDrg";
        }
        {
          title = "Cowboy Kent Rollins";
          tags = [
            "food"
            "youtube"
          ];
          url = yt_url "UClrMJRlvoyoWsVlB-7c61PQ";
        }
        {
          title = "DFBGuide";
          tags = [
            "disney"
            "youtube"
          ];
          url = yt_url "UCnpWedLQdHpZqhgTLdB9Yyg";
        }
        {
          title = "DevOps Toolbox";
          tags = [
            "devops"
            "youtube"
          ];
          url = yt_url "UCYeiozh-4QwuC1sjgCmB92w";
        }
        {
          title = "Disney Parks";
          tags = [
            "disney"
            "youtube"
          ];
          url = yt_url "UC1xwwLwm6WSMbUn_Tp597hQ";
        }
        {
          title = "Dogen";
          tags = [
            "japanese"
            "youtube"
          ];
          url = yt_url "UCSX0NhNdBA-ZnEFkYFzdw4A";
        }
        {
          title = "Dreams of Autonomy";
          tags = [
            "youtube"
          ];
          url = yt_url "UCEEVcDuBRDiwxfXAgQjLGug";
        }
        {
          title = "Dreams of Code";
          tags = [
            "software-development"
            "youtube"
          ];
          url = yt_url "UCWQaM7SpSECp9FELz-cHzuQ";
        }
        {
          title = "Driving 4 Answers";
          tags = [
            "engineering"
            "youtube"
          ];
          url = yt_url "UCwosUnVH6AINmxtqkNJ3Fbg";
        }
        {
          title = "fasterthanlime";
          tags = [
            "software-development"
            "youtube"
          ];
          url = yt_url "UCs4fQRyl1TJvoeOdekW6lYA";
        }
        {
          title = "FortNine";
          tags = [
            "engineering"
            "youtube"
          ];
          url = yt_url "UCNSMdQtn1SuFzCZjfK2C7dQ";
        }
        {
          title = "Grace Covenant Church PCA";
          tags = [
            "church"
            "youtube"
          ];
          url = yt_url "UCapTRNfNo37L96IyVCP94JA";
        }
        {
          title = "Jacob Sorber";
          tags = [
            "software-development"
            "youtube"
          ];
          url = yt_url "UCwd5VFu4KoJNjkWJZMFJGHQ";
        }
        {
          title = "Jacques";
          tags = [
            "bevy"
            "rust"
            "software-development"
            "youtube"
          ];
          url = yt_url "UCtLGtHHHkr_UBuRcp9pDiYw";
        }
        {
          title = "Jeremy Chone";
          tags = [
            "rust"
            "software-development"
            "youtube"
          ];
          url = yt_url "UCiT_r1GD7JSftnbViKHcOtQ";
        }
        {
          title = "Jon Gjengset";
          tags = [
            "rust"
            "software-development"
            "youtube"
          ];
          url = yt_url "UC_iD0xppBwwsrM9DegC5cQQ";
        }
        {
          title = "Jonathan Barouch";
          tags = [
            "music-theory"
            "youtube"
          ];
          url = yt_url "UC6iqdLTx5CYwjP5D9cadXqw";
        }
        {
          title = "Logan Smith";
          tags = [
            "rust"
            "software-development"
            "youtube"
          ];
          url = yt_url "UCnHX5FjwtQpxkCGziuh4NJA";
        }
        {
          title = "Luke Smith";
          tags = [
            "linux"
            "philosophy"
            "youtube"
          ];
          url = yt_url "UC2eYFnH61tmytImy1mTYvhA";
        }
        {
          title = "Mystic Arts";
          tags = [
            "ttrpgs"
            "youtube"
          ];
          url = yt_url "UCJQEEltSpi8LXqMH8uTrCQQ";
        }
        {
          title = "Sascha Koenig";
          tags = [
            "nixos"
            "youtube"
          ];
          url = yt_url "UCnrVJrE6JLB75nU7tZZ7BSw";
        }
        {
          title = "Slow Your Roll";
          tags = [
            "dc20"
            "ttrpg"
            "youtube"
          ];
          url = yt_url "UCdxehAZcCMOQ60azrTU283Q";
        }
        {
          title = "Sorcerer Radio";
          tags = [
            "disney"
            "music"
            "youtube"
          ];
          url = yt_url "UCKSs6PXgeYDSHTcGdaItJYw";
        }
        {
          title = "Technology Connections";
          tags = [
            "technology"
            "youtube"
          ];
          url = yt_url "UCy0tKL1T7wFoYcxCe0xjN6Q";
        }
        {
          title = "The Dungeon Coach";
          tags = [
            "dc20"
            "ttrpgs"
            "youtube"
          ];
          url = yt_url "UCz8xkTADYdRQR7GP-f2PjOA";
        }
        {
          title = "The Fantasy Forge";
          tags = [
            "ttrpgs"
            "youtube"
          ];
          url = yt_url "UCnVqE5aiTqVJdRxhszBaHoQ";
        }
        {
          title = "TnTori";
          tags = [
            "dc20"
            "ttrpgs"
            "youtube"
          ];
          url = yt_url "UCEa1G5kDN_xOcGUmq8utbNQ";
        }
        {
          title = "Untitled Linux Show";
          tags = [
            "linux"
            "youtube"
          ];
          url = yt_url "UCsGdWQMkl4Yv4fLBQ3aCC1Q";
        }
        {
          title = "Vimjoyer";
          tags = [
            "nixos"
            "youtube"
          ];
          url = yt_url "UC_zBdZ0_H_jn41FDRG7q4Tw";
        }
        {
          title = "Walt Disney Imagineering";
          tags = [
            "disney"
            "youtube"
          ];
          url = yt_url "UC4DavIB24rEr5waVY5AgZLg";
        }
        {
          title = "Willowares";
          tags = [
            "dnd"
            "ttrpgs"
            "youtube"
          ];
          url = yt_url "UCvzjoK-ypiDiWvq9jzgpHXg";
        }
        {
          title = "Zee Bashew";
          tags = [
            "dnd"
            "ttrpgs"
            "youtube"
          ];
          url = yt_url "UCCXR2kCo7Lcw_BKwWxo09kw";
        }
      ];
  };
}
