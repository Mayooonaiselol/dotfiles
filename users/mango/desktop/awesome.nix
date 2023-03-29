{ config, pkgs, ... }:
{
  xdg.configFile."awesome" = {
    source = ../../../conf/awesome;
    recursive = true;
  };
}
