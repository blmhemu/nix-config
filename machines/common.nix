{ config, pkgs, ... }:
{
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';
  services.nix-daemon.enable = true;
}
