{ config, pkgs, lib, ... }:
{
  fonts = {
    fonts = with pkgs; [
      twemoji-color-font
      material-icons
      roboto
      iosevka-bin
      (nerdfonts.override { fonts = [ "RobotoMono" "JetBrainsMono" "FiraMono" "Overpass" "Mononoki" "Ubuntu" ]; })
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
}
