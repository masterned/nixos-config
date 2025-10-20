{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gnome-calculator
    gnome-calendar
    gnome-characters
    gnome-clocks
    gnome-disk-utility
    gnome-font-viewer
    gnome-text-editor
    loupe
    nautilus
    seahorse
  ];
}
