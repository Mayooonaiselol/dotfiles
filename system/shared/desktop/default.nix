{ config, pkgs, lib, ... }:
{
  imports = [
    ./gnome.nix
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

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
    ];
  };

  qt5.enable = true;
  qt5.platformTheme = "gtk2";
  qt5.style = "gtk2";
}
