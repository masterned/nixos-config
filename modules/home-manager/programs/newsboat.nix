{ pkgs, ... }:
{
  programs.newsboat = {

    enable = true;

    extraConfig = /* config */ ''
      macro v set browser "mpv %u" ; open-in-browser ; set browser "${pkgs.xdg-utils}/bin/xdg-open"

      # unbind keys
      unbind-key ENTER
      unbind-key j
      unbind-key j
      unbind-key J
      unbind-key K

      # bind keys - vim inspired
      bind-key j down
      bind-key k up
      bind-key l open
      bind-key h quit
    '';

    urls = [
      {
        title = "Bardic Aggravation";
        tags = [
          "dc20"
          "ttrpgs"
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCg7JrN8jLxzSX8Te3NRldNA";
      }
      {
        title = "Brodie Robertson";
        tags = [
          "linux"
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCld68syR8Wi-GY_n4CaoJGA";
      }
      {
        title = "chris biscardi";
        tags = [
          "bevy"
          "rust"
          "game-development"
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCiSIL42pQRpc-8JNiYDFyzQ";
      }
      {
        title = "Code to the Moon";
        tags = [
          "rust"
          "software-development"
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCjREVt2ZJU8ql-NC9Gu-TJw";
      }
      {
        title = "CodeAesthetic";
        tags = [
          "software-development"
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCaSCt8s_4nfkRglWCvNSDrg";
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
        title = "DevOps Toolbox";
        tags = [
          "devops"
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCYeiozh-4QwuC1sjgCmB92w";
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
        title = "fasterthanlime";
        tags = [
          "software-development"
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCs4fQRyl1TJvoeOdekW6lYA";
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
        title = "Grace Covenant Church PCA";
        tags = [
          "church"
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCapTRNfNo37L96IyVCP94JA";
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
        title = "Jacques";
        tags = [
          "bevy"
          "rust"
          "software-development"
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCtLGtHHHkr_UBuRcp9pDiYw";
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
        title = "Jonathan Barouch";
        tags = [
          "music-theory"
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UC6iqdLTx5CYwjP5D9cadXqw";
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
        title = "Mystic Arts";
        tags = [
          "ttrpgs"
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCJQEEltSpi8LXqMH8uTrCQQ";
      }
      {
        title = "Slow Your Roll";
        tags = [
          "dc20"
          "ttrpg"
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCdxehAZcCMOQ60azrTU283Q";
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
          "dc20"
          "ttrpgs"
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCz8xkTADYdRQR7GP-f2PjOA";
      }
      {
        title = "The Fantasy Forge";
        tags = [
          "ttrpgs"
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCnVqE5aiTqVJdRxhszBaHoQ";
      }
      {
        title = "TnTori";
        tags = [
          "dc20"
          "ttrpgs"
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCEa1G5kDN_xOcGUmq8utbNQ";
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
        title = "Willowares";
        tags = [
          "dnd"
          "ttrpgs"
          "youtube"
        ];
        url = "https://www.youtube.com/feeds/videos.xml?channel_id=UCvzjoK-ypiDiWvq9jzgpHXg";
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
