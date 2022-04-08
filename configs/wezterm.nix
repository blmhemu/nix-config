{ config, pkgs, ... }:
{
  imports = [ ../modules/wezterm.nix ];
  programs.wezterm = {
    enable = true;
    package = pkgs.runCommand "wezterm-0.0.0" { } "mkdir $out";
    extraConfig = ''
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
  };
}
