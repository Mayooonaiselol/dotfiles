{ config, pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    cargo
    nodePackages.npm
    gcc
  ];
}
