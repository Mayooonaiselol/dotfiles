{ config, pkgs, lib, ... }:
{
  programs = {
    sway = {
      enable = true;

      extraPackages = with pkgs; [
        rofi
        waybar
        kitty
        wl-clipboard
        wayland-utils
        grim
        slurp
        autotiling
        qt5.qtwayland
        xdg_utils
        swaybg
        swaylock-effects
        swayidle
        light
        dunst
      ];

      extraSessionCommands = ''
          export XDG_SESSION_DESKTOP=sway
        	export SDL_VIDEODRIVER=wayland
        	export QT_QPA_PLATFORM=wayland-egl
        	export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
        	export MOZ_ENABLE_WAYLAND=1
        	export CLUTTER_BACKEND=wayland
        	export ECORE_EVAS_ENGINE=wayland-egl
        	export ELM_ENGINE=wayland_eg
        	export NO_AT_BRIDGE=1
      '';
    };
  };
}
