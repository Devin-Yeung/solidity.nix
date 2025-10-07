{
  description = "A collection of solidity toolchains";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        foundry-zksync = pkgs.callPackage ./formula/foundry-zksync.nix { };
      in
      {
        packages = {
          inherit foundry-zksync;
        };
      }
    );
}
