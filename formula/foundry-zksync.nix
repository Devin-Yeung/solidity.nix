{
  stdenv,
  system,
  fetchurl,
  ...
}:

let
  archMap = {
    "x86_64-linux" = "linux_amd64";
    "aarch64-linux" = "linux_arm64";
    "x86_64-darwin" = "darwin_amd64";
    "aarch64-darwin" = "darwin_arm64";
  };

  arch = archMap.${system} or (throw "Unsupported system: ${system}");

  sha256 = {
    "x86_64-linux" = "sha256-QakGq4UTjeASJ7OvpLQfx0CgR6BsptZuFpQgXhzC5LU=";
    "aarch64-linux" = "sha256-kfm2pqHQ37/qv05sh6GUXG2HF0o+086uvPbUn3s2+tw=";
    "x86_64-darwin" = "sha256-vnfONSds9T0wsx1p90KG2dFiSIyI5MN1dOxGlr8dOrQ=";
    "aarch64-darwin" = "sha256-iE5/Pfd6eXZ97GH0bil1ARKaC0VNa3FO1oNkodtKeUU=";
  };

  version = "0.0.29";
in

stdenv.mkDerivation {
  inherit version;
  pname = "foundry-zksync";
  src = fetchurl {
    url = "https://github.com/matter-labs/foundry-zksync/releases/download/foundry-zksync-v${version}/foundry_zksync_v${version}_${arch}.tar.gz";
    sha256 = sha256.${system};
  };

  sourceRoot = ".";

  installPhase = ''
    mkdir -p $out/bin
    cp cast $out/bin/
    cp forge $out/bin/
  '';

  dontBuild = true;
  dontConfigure = true;
}
