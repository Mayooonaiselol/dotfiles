{ config, pkgs, ... }:
{
  home.file.".config/nvim".source = ../../../conf/nvim;
}
