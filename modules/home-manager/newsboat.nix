{ pkgs, ... }:
{
  programs.newsboat = {

    enable = true;

    extraConfig = ''
      macro v set browser "mpv %u" ; open-in-browser ; set browser "${pkgs.xdg-utils}/bin/xdg-open"
    '';

    urls = [
      {
        title = "Brodie Robertson";
        tags = [
          "linux"
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCld68syR8Wi-GY_n4CaoJGA";
      }
      {
        title = "Continuous Delivery";
        tags = [
          "software-development"
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCCfqyGl3nq_V0bo64CjZh8g";
      }
      {
        title = "Cowboy Kent Rollins";
        tags = [
          "food"
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UClrMJRlvoyoWsVlB-7c61PQ";
      }
      {
        title = "DFBGuide";
        tags = [
          "disney"
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCnpWedLQdHpZqhgTLdB9Yyg";
      }
      {
        title = "Disney Parks";
        tags = [
          "disney"
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC1xwwLwm6WSMbUn_Tp597hQ";
      }
      {
        title = "Dogen";
        tags = [
          "japanese"
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCSX0NhNdBA-ZnEFkYFzdw4A";
      }
      {
        title = "Dreams of Autonomy";
        tags = [
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCEEVcDuBRDiwxfXAgQjLGug";
      }
      {
        title = "Dreams of Code";
        tags = [
          "software-development"
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCWQaM7SpSECp9FELz-cHzuQ";
      }
      {
        title = "Driving 4 Answers";
        tags = [
          "engineering"
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCwosUnVH6AINmxtqkNJ3Fbg";
      }
      {
        title = "Feral Foraging";
        tags = [
          "food"
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCmngd6QbE67Dvc9kRnrlToA";
      }
      {
        title = "FortNine";
        tags = [
          "engineering"
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCNSMdQtn1SuFzCZjfK2C7dQ";
      }
      {
        title = "Jacob Sorber";
        tags = [
          "software-development"
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCwd5VFu4KoJNjkWJZMFJGHQ";
      }
      {
        title = "Jeremy Chone";
        tags = [
          "rust"
          "software-development"
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCiT_r1GD7JSftnbViKHcOtQ";
      }
      {
        title = "Jon Gjengset";
        tags = [
          "rust"
          "software-development"
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC_iD0xppBwwsrM9DegC5cQQ";
      }
      {
        title = "Logan Smith";
        tags = [
          "rust"
          "software-development"
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCnHX5FjwtQpxkCGziuh4NJA";
      }
      {
        title = "Luke Smith";
        tags = [
          "linux"
          "philosophy"
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC2eYFnH61tmytImy1mTYvhA";
      }
      {
        title = "Mental Outlaw";
        tags = [
          "linux"
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC7YOGHUfC1Tb6E4pudI9STA";
      }
      {
        title = "Sorcerer Radio";
        tags = [
          "disney"
          "music"
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCKSs6PXgeYDSHTcGdaItJYw";
      }
      {
        title = "Technology Connections";
        tags = [
          "linux"
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCy0tKL1T7wFoYcxCe0xjN6Q";
      }
      {
        title = "The Dungeon Coach";
        tags = [
          "ttrpgs"
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCz8xkTADYdRQR7GP-f2PjOA";
      }
      {
        title = "Vimjoyer";
        tags = [
          "technology"
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC_zBdZ0_H_jn41FDRG7q4Tw";
      }
      {
        title = "Walt Disney Imagineering";
        tags = [
          "disney"
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC4DavIB24rEr5waVY5AgZLg";
      }
      {
        title = "Zee Bashew";
        tags = [
          "dnd"
          "ttrpgs"
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCCXR2kCo7Lcw_BKwWxo09kw";
      }
    ];
  };
}
