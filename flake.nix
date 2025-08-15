{
  description = "Chris' NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      nixosConfigurations = {
        mymachine = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/mymachine.nix
          ];
        };
      };
    };
}