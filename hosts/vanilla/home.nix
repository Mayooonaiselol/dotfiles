{ config, pkgs, ... }:

{
  imports = [
    ../../users/shared/editors/default.nix
    ../../users/shared/apps/default.nix
    ../../users/shared/dev/default.nix
    ../../users/vanilla/desktop/default.nix
  ];

  home.username = "mayo";
  home.homeDirectory = "/home/mayo";

  home.stateVersion = "22.11";

  programs.home-manager.enable = true;

  home.pointerCursor = {
    package = pkgs.quintom-cursor-theme;
    name = "Quintom_Snow";
    size = 34;
    gtk.enable = true;
    x11.enable = true;
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.colloid-gtk-theme;
      name = "Colloid-Dark";
    };
    iconTheme = {
      package = pkgs.colloid-icon-theme;
      name = "Colloid-dark";
    };
    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
  };

  home.sessionVariables.GTK_THEME = "Colloid-Dark";
}
