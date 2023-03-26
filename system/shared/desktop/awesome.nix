{ config, pkgs, lib, ... }:
{
  services.xserver = {
    windowManager = {
      awesome = {
        enable = true;
        package = pkgs.awesome-git;
      };
    };
  };
}
