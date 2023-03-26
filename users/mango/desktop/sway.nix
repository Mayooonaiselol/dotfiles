{ config, pkgs, ... }:
{
  xdg.configFile."sway/config".source = ../../../conf/sway/config;
  xdg.configFile."swaylock/config".source = ../../../conf/swaylock/config;
  xdg.configFile."swaynag/config".source = ../../../conf/swaynag/config;
}
