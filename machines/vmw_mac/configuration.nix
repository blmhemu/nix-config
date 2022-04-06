{ config, lib, pkgs, ... }:
let
  username = "hbollamreddi";
in
{
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
      ];
      home.packages = with pkgs; [
        kubectl
      ];
    };
  };
}
