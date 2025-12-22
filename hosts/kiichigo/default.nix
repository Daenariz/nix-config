{ inputs, outputs, ... }:

{
  imports = [
    #./wyoming.nix
    #  ./homeassistant.nix
    ./boot.nix
    ./hardware.nix
    ./networking.nix
    ./packages.nix
    #./services.nix
    ./users.nix
    ./secrets
    inputs.core.nixosModules.common
    inputs.core.nixosModules.openssh
    inputs.core.nixosModules.tailscale
    inputs.core.nixosModules.jellyfin

    outputs.nixosModules.common

  ];

  services.jellyfin = {
    enable = true;
    reverseProxy = {
    subdomain = "media";
    forceSSL = false;
    };
    libraries = [
      "books/audiobooks"
      "movies"
      "music"
      "shows"
    ];
  };

   services.tailscale = {
    enable = true;
    enableSSH = true;
    loginServer = "https://head.negitorodon.de";
  };


  programs.ssh.startAgent = true;

  services.openssh = {
    enable = true;
    #    ports = [ 3407 ];
  };
  system.stateVersion = "26.06";
}
