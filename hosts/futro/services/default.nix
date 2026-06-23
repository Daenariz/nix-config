{
  imports = [
    ./raid.nix
    ./dns.nix
    ./nginx.nix
    ./tailscale.nix
    ./matrix-synapse.nix
    ./nextcloud.nix
    ./radicale.nix
    ./vaultwarden.nix
    ./open-webui-oci.nix
    ./virtualisation.nix
    # ./mailserver.nix
    ./kokushi-musou.nix
  ];
}
