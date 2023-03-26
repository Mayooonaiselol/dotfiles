{ config, pkgs, lib, ... }:
{
  environment = {
    systemPackages = with pkgs; [
      lsof
      virt-manager
      pulseaudio
      tree
      kitty
      wget
      git
      htop
      pamixer
      pavucontrol
      zip
      unzip
      psmisc
      blanket
    ];
  };

  programs = {
    gamemode.enable = true;
    dconf.enable = true;
  };

  virtualisation.libvirtd.enable = true;
}
