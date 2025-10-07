{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "aderyn";
  version = "0.6.1";

  doCheck = false;

  src = fetchFromGitHub {
    owner = "Cyfrin";
    repo = "aderyn";
    rev = "aderyn-v${version}";
    sha256 = "sha256-IT+3KqUlQHDOvIkPAj/6eZm6VJJcfSQNfccJkkyGZbc=";
  };

  cargoHash = "sha256-JmM4OjemW/UhYKyAScKYUzO//qylZTuJPYuLF8JUvJk=";

  cargoBuildFlags = [
    "-p"
    "aderyn"
  ];

  meta = with lib; {
    description = "A powerful Solidity static analyzer that takes a bird's eye view over your smart contracts.";
    homepage = "https://github.com/Cyfrin/aderyn";
    license = licenses.gpl3;
    maintainers = [ ];
    platforms = platforms.all;
  };
}
