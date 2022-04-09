# nix-config
These are my dotfiles on steroids (powered by nix).

## Install

```sh
# Install Nix. Follow the instructions at https://nixos.org/
sh <(curl -L https://nixos.org/nix/install)
# Run below for bootstrapped setup
nix build --extra-experimental-features "flakes nix-command" .\#vmw_mac
```
## Thoughts
### Shell
* https://htr3n.github.io/2018/07/faster-zsh/
