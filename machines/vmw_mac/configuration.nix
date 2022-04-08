{ config, lib, pkgs, ... }:
let
  username = "hbollamreddi";
in
{
  imports = [
    ../../modules/pam.nix
  ];

  security.pam.enableSudoTouchIdAuth = true;
  security.pam.enableSudoTouchIdReattach = true;

  homebrew = {
    enable = true;
    autoUpdate = true;
    cleanup = "zap";
    global = {
      brewfile = true;
      noLock = true;
    };
  };

  homebrew = {
    brews = [
      "pam-reattach"
    ];

    taps = [
      "homebrew/core"
      "homebrew/cask"
      "homebrew/cask-drivers"
      "homebrew/cask-versions"
      "homebrew/cask-fonts"
    ];

    casks = [
      "wezterm"
    ];
  };
  # users.users."${username}" = {
  # home = "/Users/${username}";
  # shell = pkgs.zsh;
  # };
  programs.zsh.enable = true;
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users."${username}" = {
      home.stateVersion = "21.11";
      imports = [
        ../../configs/tmux.nix
        ../../configs/bat.nix
        ../../configs/wezterm.nix
        ../../configs/neovim.nix
        ../../configs/starship.nix
      ];
      home.packages = with pkgs; [
        kubectl
      ];
    };
  };
}
