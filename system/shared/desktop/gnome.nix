{ config, pkgs, lib, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      gjs
      gnome.gnome-tweaks
      gnome.gnome-terminal
      gnomeExtensions.desktop-icons-ng-ding
    ];

    gnome.excludePackages = (with pkgs; [
      gnome-photos
      gnome-tour
      gnome-console
    ]) ++ (with pkgs.gnome; [
      cheese # webcam tool
      gnome-music
      gnome-maps
      gedit # text editor
      epiphany # web browser
      geary # email reader
      evince # document viewer
      gnome-characters
      gnome-clocks
      gnome-contacts
      yelp
      gnome-software
      simple-scan
      totem # video player
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
    ]);
  };
}
