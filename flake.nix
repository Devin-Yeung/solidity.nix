{
  description = "A collection of solidity toolchains";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    crane.url = "github:ipetkov/crane";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
      crane,
      rust-overlay,
    }@inputs:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        overlays = [ (import rust-overlay) ];
        pkgs = import nixpkgs {
          inherit system overlays;
        };
        aderyn = pkgs.callPackage ./formula/aderyn.nix { inherit inputs; };
        foundry-zksync = pkgs.callPackage ./formula/foundry-zksync.nix { inherit inputs; };
      in
      {
        packages = {
          inherit aderyn foundry-zksync;
        };
      }
    );
}
