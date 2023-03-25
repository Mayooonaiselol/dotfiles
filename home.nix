{ config, pkgs, ... }:

{
  home.username = "mayo";
  home.homeDirectory = "/home/mayo";

  home.stateVersion = "22.11";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    discord
    obs-studio
    picom
    gimp
    libnotify
    inotify-tools
    betterlockscreen
    flameshot
    pfetch
    lsd
    rofi
    libreoffice-fresh
    xclip
    drawing
  ];

  services = {
    mpris-proxy.enable = true;
    mpd = {
      enable = true;
      musicDirectory = "~/Music";
      extraConfig = ''
        auto_update "yes"
        restore_paused "yes"

        music_directory "~/Music"
        playlist_directory "~/.config/mpd/playlists"
        db_file "~/.config/mpd/mpd.db"
        log_file "syslog"
        pid_file "/tmp/mpd.pid"
        state_file "~/.config/mpd/mpd.state"
 
        audio_output {
          type               "pipewire"
          name               "PipeWire Sound Server"
        }

        audio_output {
          type "fifo"
          name "Visualizer"
          format "44100:16:2"
          path "/tmp/mpd.fifo"
        }
      '';
    };
  };

  programs.ncmpcpp = {
    enable = true;
    package = pkgs.ncmpcpp.override { 
      visualizerSupport = true; 
      clockSupport = true;
    };
    settings = {
      # dir
      ncmpcpp_directory = "~/.config/ncmpcpp";
      lyrics_directory = "~/.config/ncmpcpp/lyrics";
      mpd_music_dir = "~/Music";

      # visualizer;
      visualizer_data_source = "/tmp/mpd.fifo";
      visualizer_output_name = "mpd_visualizer";
      visualizer_type = "ellipse";
      visualizer_look = "●●";
      visualizer_color = "7, 5, 6";

      # appearance;
      colors_enabled = "yes";
      playlist_display_mode = "classic";
      user_interface = "classic";
      volume_color = "white";

      # window;
      song_window_title_format = "Music";
      statusbar_visibility = "yes";
      header_visibility = "no";
      titles_visibility = "no";

      # progress bar;
      progressbar_look = "━━━";
      progressbar_color = "black";
      progressbar_elapsed_color = "blue";

      # colors;
      main_window_color = "blue";
      current_item_inactive_column_prefix = "$b$5";
      current_item_inactive_column_suffix = "$/b$5";
      color1 = "green";
      color2 = "blue";
    };
  };

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

  # home.file.".config/kitty" = {
  #   source = ~/config/kitty;
  #   recursive = true;
  # };
}
