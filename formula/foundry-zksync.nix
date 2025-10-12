{
  pkgs,
  lib,
  fetchFromGitHub,
  inputs,
  ...
}:
let
  src = fetchFromGitHub {
    owner = "matter-labs";
    repo = "foundry-zksync";
    tag = "foundry-zksync-v0.0.30";
    hash = "sha256-dGDFfVpne3kyBCvnkiRAdN0nwcBWJD1hRLQBk3VvDWQ=";
  };

  toolchain = pkgs.rust-bin.fromRustupToolchainFile "${src}/rust-toolchain";

  craneLib = (inputs.crane.mkLib pkgs).overrideToolchain toolchain;
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

  pname = src.repo;
  version = src.tag;
  inherit src;

  doCheck = false;

  nativeBuildInputs =
    with pkgs;
    [
      pkg-config
    ]
    ++ lib.optionals stdenv.hostPlatform.isDarwin [ ];

  buildInputs =
    with pkgs;
    [
      openssl.dev
    ]
    ++ lib.optionals stdenv.hostPlatform.isDarwin [ ];

  env = {
    OPENSSL_NO_VENDOR = "1";
  };
}
