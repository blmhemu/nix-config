{ config, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    shortcut = "a";
    baseIndex = 1;
    escapeTime = 20;
    terminal = "tmux-256color";
    historyLimit = 100000;
    keyMode = "vi";
    extraConfig = ''
      # Mouse works as expected
      set-option -g mouse on
      # Easy-to-remember split pane commands
      bind \\ split-window -h
      bind - split-window -v
      unbind '"'
      unbind %
      # Good looking terminal colors
      # https://gpanders.com/blog/the-definitive-guide-to-using-tmux-256color-on-macos
      # https://gist.github.com/joshuarli/247018f8617e6715e1e0b5fd2d39bb6c
      set -sa terminal-overrides ',wezterm:RGB'
    '';
  };
}
