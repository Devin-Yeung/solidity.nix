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

        formulaDir = ./formula;
        formulas = builtins.attrNames (builtins.readDir formulaDir);

        packages = builtins.listToAttrs (
          map (file: {
            name = builtins.replaceStrings [ ".nix" ] [ "" ] file;
            value = pkgs.callPackage "${formulaDir}/${file}" { };
          }) formulas
        );
      in
      {
        inherit packages;
      }
    );
}
