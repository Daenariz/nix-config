{ config, ... }:
{

  nixpkgs.config.permittedInsecurePackages = [
    "docker-28.5.2"
  ];

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
      flags = [ "--all" ];
    };
  };

  virtualisation.containers.storage.settings = {
    storage = {
      driver = "overlay";
      runroot = "/run/containers/storage";
      graphroot = "/data/podman";
    };
  };
}
