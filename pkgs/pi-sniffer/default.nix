{
  stdenv,
  lib,
  pkg-config,
  glib,
  json-glib,
  dpkg,
  bluez,
  bluez-tools,
  openssl,
  paho-mqtt-c,
  ...
}:

stdenv.mkDerivation {
  pname = "pi-sniffer";
  version = "hilbigit-forked-2025-09-17";

  src = fetchGit {
    url = "ssh://git@forgejo.tooling.hilbigit.com/vcr-dev-tracker/pi-sniffer.git";
    rev = "aeb4cbced82fc1f17c310927b7815aee5babd82e";
  };

  nativeBuildInputs = [ pkg-config ];

  buildInputs = [
    glib
    json-glib
    dpkg
    bluez
    bluez-tools
    openssl
    paho-mqtt-c
  ];

  postBuild = ''
    SRC="src/scan.c src/mqtt_send.c src/model/device.c"  make scanwithmqtt
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    cp scanwithmqtt $out/bin/pi-sniffer
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
