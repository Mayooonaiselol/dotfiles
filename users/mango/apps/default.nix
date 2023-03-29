{ config, pkgs, ... }:
{
  home.file.".config/kitty".source = ../../../conf/kitty;
}
