{
  pkgs,
  fetchFromGitHub,
  inputs,
  ...
}:
let
  pname = "aderyn";
  version = "0.6.1";
  src = fetchFromGitHub {
    owner = "Cyfrin";
    repo = "aderyn";
    rev = "aderyn-v${version}";
    sha256 = "sha256-IT+3KqUlQHDOvIkPAj/6eZm6VJJcfSQNfccJkkyGZbc=";
  };

  craneLib = inputs.crane.mkLib pkgs;
in
craneLib.buildPackage {
  # Some crates download stuff from the network while compiling
  # Allows derivation to access network
  #
  # Users of this package must set options to indicate that the sandbox conditions can be relaxed for this package.
  # These are:
  # - When used in a flake, set the flake's config with this line: nixConfig.sandbox = false;
  # - From the command line with nix <command>, add one of these options:
  #   - --option sandbox false
  #   - --no-sandbox
  __noChroot = true;

  inherit version pname;
  inherit src;

  doCheck = false;

  cargoExtraArgs = "-p aderyn";
}
