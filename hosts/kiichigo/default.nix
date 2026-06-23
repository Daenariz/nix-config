{
  config,
  inputs,
  outputs,
  ...
}:
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
    inputs.synix-stable.nixosModules.common
    inputs.synix-stable.nixosModules.openssh
    inputs.synix-stable.nixosModules.tailscale
    inputs.synix-stable.nixosModules.jellyfin

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
    tailnets = {
      personal = {
        loginServer = "https://head.negitorodon.de";
        authKeyFile = config.sops.secrets."tailscale/auth-key".path;
        enableSSH = true;
      };
    };
  };
  #
  # services.tailscale = {
  #   enable = true;
  #   enableSSH = true;
  #   loginServer = "https://head.negitorodon.de";
  # };

  programs.ssh.startAgent = true;

  services.openssh = {
    enable = true;
    #    ports = [ 3407 ];
  };
  system.stateVersion = "26.06";
}
