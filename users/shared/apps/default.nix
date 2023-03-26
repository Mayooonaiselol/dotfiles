{ config, pkgs, ... }:
{
 home.packages = with pkgs; [
    discord
    obs-studio
    gimp
    flameshot
    pfetch
    lsd
    libreoffice-fresh
    drawing
    firefox
  ];
}
