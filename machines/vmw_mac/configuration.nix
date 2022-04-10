{ config, lib, pkgs, ... }:
let
  username = "hbollamreddi";
in
{
  imports = [
    ../../modules/pam.nix
  ];

  security.pam.enableSudoTouchIdAuth = true;
  security.pam.enablePamReattach = true;

  homebrew = {
    enable = true;
    autoUpdate = true;
    cleanup = "zap";
    global = {
      brewfile = true;
      noLock = true;
    };

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
      "maccy"
      "karabiner-elements"
    ];
  };

  users.users."${username}" = {
    home = "/Users/${username}";
  };
  programs.zsh.enable = true;
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    users."${username}" = {
      home.stateVersion = "21.11";
      imports = [
        ../../configs/bat.nix
        ../../configs/neovim.nix
        ../../configs/starship.nix
        ../../configs/tmux.nix
        ../../configs/wezterm.nix
      ];
      home.packages = with pkgs; [
        kubectl
      ];
    };
  };
}
