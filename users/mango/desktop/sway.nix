{ config, pkgs, ... }:
{
  home.file.".config/sway".source = ../../../conf/sway;
  home.file.".config/swaylock".source = ../../../conf/swaylock;
  home.file.".config/swaynag".source = ../../../conf/swaynag;
}
