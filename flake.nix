{
  description = "Nix-powered system configuration & dotfiles";

  inputs = {
    # Follow the latest nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager }: {

    darwinConfigurations."vmw_mac" = darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      modules = [
        ./machines/common.nix
        home-manager.darwinModule
        ./machines/vmw_mac/configuration.nix
      ];
    };

    vmw_mac = self.darwinConfigurations.vmw_mac.system;

    packages.x86_64-linux.hello = nixpkgs.legacyPackages.x86_64-linux.hello;

    defaultPackage.x86_64-linux = self.packages.x86_64-linux.hello;

  };
}
