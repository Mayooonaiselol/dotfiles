{ config, pkgs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ../../system/shared/desktop/default.nix
    ../../system/shared/apps/default.nix
    ../../system/shared/dev/default.nix
    ../../system/mango/env.nix
    ../../system/mango/fonts.nix
    ../../system/mango/hardware.nix
    ../../system/mango/services.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
      timeout = 2;
    };
    #kernelPackages = pkgs.linuxPackages_xanmod;
    #extraModulePackages = with pkgs; [ linuxKernel.packages.linux_xanmod.rtl8821ce ];
    extraModulePackages = [ config.boot.kernelPackages.rtl8821ce ];
    blacklistedKernelModules = [ "rtw88_8821ce" ];
  };

  networking = {
    hostName = "mayo_on_linux";
    networkmanager.enable = true;
  };

  i18n.defaultLocale = "en_IN";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  time.timeZone = "Asia/Kolkata";
  
  nixpkgs.config.allowUnfree = true;

  users.users.mayo = {
    isNormalUser = true;
    description = "mayo";
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "storage" "libvirtd" ];
    shell = pkgs.zsh;
    home = "/home/mayo";
  };

  security = {
    # protectkernelimage will prevent hibernate!
    rtkit.enable = true;
  };

  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = "experimental-features = nix-command flakes";
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-then 7d";
    };
  };

  system.stateVersion = "22.11";
}
