{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../system/shared/desktop/default.nix
    ../../system/shared/editors/default.nix
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

  hardware = {

    bluetooth = {
      enable = true;
      powerOnBoot = false;
    };

    cpu.intel.updateMicrocode = true;

    pulseaudio.enable = false;

    enableAllFirmware = true;
    enableRedistributableFirmware = true;

    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
        vaapiIntel
        intel-compute-runtime
      ];
    };
  };

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

  environment = {
    systemPackages = with pkgs; [
      lsof
      virt-manager
      pulseaudio
      firefox
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

  services = {

    printing.enable = true;
    blueman.enable = true;
    flatpak.enable = true;
    #tlp.enable = true; CONFLICT DUE TO POWER-PROFILE-DAEMON BY GNOME

    pipewire = {
      enable = true;
      jack.enable = true;
      pulse.enable = true;
    };

    xserver = {

      enable = true;
      videoDrivers = [ "modesetting" ];
      deviceSection = ''
        Option "TearFree" "true"
      '';
      excludePackages = [ pkgs.xterm ];
      layout = "us";
      libinput = {
        enable = true;
        touchpad = {
          tapping = true;
        };
      };

      displayManager.gdm.enable = true;
    };
  };

  programs = {
    gamemode.enable = true;
    dconf.enable = true;
  };

  virtualisation.libvirtd.enable = true;

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
