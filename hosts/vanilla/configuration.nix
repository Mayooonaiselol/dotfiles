{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../users/shared/desktop/default.nix
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

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
    ];
  };

  qt5.enable = true;
  qt5.platformTheme = "gtk2";
  qt5.style = "gtk2";

  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };

  environment = {

    sessionVariables = rec {
      _JAVA_AWT_WM_NONREPARENTING = "1";
      MUTTER_DEBUG_FORCE_KMS_MODE = "simple";
      MOZ_ENABLE_WAYLAND = "1";
      XDG_CACHE_HOME = "\${HOME}/.cache";
      XDG_CONFIG_HOME = "\${HOME}/.config";
      XDG_BIN_HOME = "\${HOME}/.local/bin";
      XDG_DATA_HOME = "\${HOME}/.local/share";

      PATH = [
        "\${HOME}/.bin"
        "\${XDG_BIN_HOME}"
        "\${HOME}/.node_modules"
      ];
    };

    systemPackages = with pkgs; [
      (python3.withPackages (ps: with ps; [ pandas numpy matplotlib ]))
      lsof
      virt-manager
      pulseaudio
      firefox
      tree
      cargo
      nodePackages.npm
      kitty
      neovim
      wget
      git
      htop
      pamixer
      pavucontrol
      gcc
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

  fonts = {
    fonts = with pkgs; [
      twemoji-color-font
      material-icons
      roboto
      (nerdfonts.override { fonts = [ "RobotoMono" "JetBrainsMono" ]; })
    ];

    fontconfig = {
      enable = true;

      defaultFonts = {
        serif = [ "RobotoMono Regular" ];
        sansSerif = [ "RobotoMono Regular" ];
        monospace = [ "JetBrainsMono Nerd Font" ];
        emoji = [ "Twitter Color Emoji" ];
      };
    };
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
