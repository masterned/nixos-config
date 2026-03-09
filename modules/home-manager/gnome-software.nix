{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gnome-calculator
    gnome-characters
    gnome-font-viewer
    nautilus
    seahorse
  ];
}
