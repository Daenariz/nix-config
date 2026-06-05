{
  pkgs ? import <nixpkgs> { config.allowUnfree = true; },
}:
pkgs.stdenv.mkDerivation rec {
  pname = "riichi-city";
  version = "2.2.3";

  src = pkgs.fetchurl {
    url = "https://d3qgi0t347dz44.cloudfront.net/release/linuxpack/default_prod_Linux_2.2.3.zip";
    sha256 = "sha256-I+q3bsqcD9om8R42Cf9nIjpJwlSNi0vyL0r39QkTbCU=";
  };

  nativeBuildInputs = [ pkgs.unzip ];

  installPhase = ''
    mkdir -p $out/opt/riichi-city-source

    cp -r ./* $out/opt/riichi-city-source/
    chmod +x $out/opt/riichi-city-source/Mahjong-JP.x86_64

    mkdir -p $out/bin
    cat > $out/bin/riichi-city <<EOF
    #!/bin/sh
    GAME_DIR="\$HOME/.local/share/riichi-city-nix"
    SOURCE_DIR="$out/opt/riichi-city-source"

    echo "Checking Game-Data..."
    mkdir -p "\$GAME_DIR"

    cp -ru "\$SOURCE_DIR/"* "\$GAME_DIR/"
    chmod -R +w "\$GAME_DIR"
    chmod +x "\$GAME_DIR/Mahjong-JP.x86_64"

    rm -f "\$GAME_DIR/Mahjong-JP_Data/StreamingAssets/"*.mp4 2>/dev/null || true

    echo "Starting Riichi City via steam-run..."

    exec ${pkgs.steam-run}/bin/steam-run "\$GAME_DIR/Mahjong-JP.x86_64" "\$@"
    EOF

    chmod +x $out/bin/riichi-city
  '';

  meta = with pkgs.lib; {
    description = "Riichi City (Writable Copy via steam-run)";
    platforms = [ platforms.x86_64 ];
  };
}
