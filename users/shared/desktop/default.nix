{ config, pkgs, lib, ... }:
{
  imports = [
    ./gnome.nix
    ./awesome.nix
    ./sway.nix
  ];

  environment.systemPackages = with pkgs; [
    picom
    libnotify
    inotify-tools
    betterlockscreen
    rofi
    xclip
    brightnessctl
    wlr-randr
    xorg.xrandr
    mesa
    libsForQt5.qt5.qtgraphicaleffects
  ];
}
