{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.programs.wezterm;
in
{
  options = {
    programs.wezterm = {
      enable = mkEnableOption "wezterm";

      package = mkOption {
        type = types.package;
        default = pkgs.wezterm;
        defaultText = literalExpression "pkgs.wezterm";
        description = "The Wezterm package to install.";
      };

      settings = mkOption {
        type = types.lines;
        default = "";
        example = literalExpression ''
          local wezterm = require 'wezterm';
          return {
            font = wezterm.font("JetBrains Mono"),
            font_size = 16.0,
            color_scheme = "Tomorrow Night",
            hide_tab_bar_if_only_one_tab = true,
            default_prog = { "zsh", "--login", "-c", "tmux attach -t dev || tmux new -s dev" },
            keys = {
              {key="n", mods="SHIFT|CTRL", action="ToggleFullScreen"},
            }
          }
        '';
        description = ''
          Configuration written to
          <filename>$XDG_CONFIG_HOME/wezterm/wezterm.lua</filename>. See
          <link xlink:href="https://wezfurlong.org/wezterm/config/files.html"/>
          for how to configure.
        '';
      };
    };
  };

  config = mkMerge [
    (mkIf cfg.enable {
      home.packages = [ cfg.package ];

      xdg.configFile."wezterm/wezterm.lua" = mkIf (cfg.settings != "") {
        text = cfg.settings;
      };
    })
  ];
}
