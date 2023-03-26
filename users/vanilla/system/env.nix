{ config, pkgs, ... }:
{
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
  };
}
