{
  lib,
  stdenv,
  fetchFromGitHub,
  pkg-config,
  glib,
  json-glib,
  dpkg,
  ...
}:

stdenv.mkDerivation rec {
  pname = "pi-sniffer";
  version = "unstable-2025-03-03";

  src = fetchFromGitHub {
    owner = "IanMercer";
    repo = "pi-sniffer";
    rev = "2432e1f1e5cc1c408524bd195c6b32b4ca904321";
    hash = "sha256-Rn4fKzYWQHSbhVCDFdVOWTj9WyN3ehh5kNQSwtCRLbg=";
  };

  nativeBuildInputs = [
    pkg-config
  ];

  buildInputs = [
    glib
    json-glib
    dpkg
  ];

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp scan $out/bin/pi-sniffer
    runHook postInstall
  '';

  meta = {
    description = "Sniffer for Bluetooth LE on Raspberry Pi";
    homepage = "https://github.com/IanMercer/pi-sniffer";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ ];
    mainProgram = "pi-sniffer";
    platforms = lib.platforms.all;
  };
}
