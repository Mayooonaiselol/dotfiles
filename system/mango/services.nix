{ config, pkgs, lib, ... }:
{
  services = {

    printing.enable = true;
    blueman.enable = true;
    flatpak.enable = true;

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

}
