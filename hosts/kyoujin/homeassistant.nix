# Auto-generated using compose2nix v0.3.2-pre.
{
  pkgs,
  lib,
  config,
  ...
}:

{
  # Runtime
  virtualisation.podman = {
    enable = true;
    autoPrune.enable = true;
    dockerCompat = true;
  };

  # Enable container name DNS for all Podman networks.
  networking.firewall.interfaces =
    let
      matchAll = if !config.networking.nftables.enable then "podman+" else "podman*";
    in
    {
      "${matchAll}".allowedUDPPorts = [ 53 ];
    };

  virtualisation.oci-containers.backend = "podman";

  # Containers
  virtualisation.oci-containers.containers."homeassistant" = {
    image = "ghcr.io/home-assistant/home-assistant:stable";
    volumes = [
      "/data/home-assistant:/config:rw"
      "/etc/localtime:/etc/localtime:ro"
      "/run/dbus:/run/dbus:ro"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network=host"
      "--privileged"
    ];
  };
  systemd.services."podman-homeassistant" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    partOf = [
      "podman-compose-hadc2nix-root.target"
    ];
    wantedBy = [
      "podman-compose-hadc2nix-root.target"
    ];
  };

  # Root service
  # When started, this will automatically create all resources and start
  # the containers. When stopped, this will teardown all resources.
  systemd.targets."podman-compose-hadc2nix-root" = {
    unitConfig = {
      Description = "Root target generated by compose2nix.";
    };
    wantedBy = [ "multi-user.target" ];
  };

  ## Custom added contents
  ###################################################################################
  #  systemd.timers.update-containers = {
  #    timerConfig = {
  #      Unit = "update-containers.service";
  #      OnCalendar = "Mon 02:00";
  #    };
  #    wantedBy = [ "timers.target" ];
  #  };
  #  systemd.services.update-containers = {
  #    serviceConfig = {
  #      Type = "oneshot";
  #      ExecStart = lib.getExe (pkgs.writeShellScriptBin "update-containers" ''
  #        images=$(${pkgs.podman}/bin/podman ps -a --format="{{.Image}}" | sort -u)
  #
  #        for image in $images; do
  #          ${pkgs.podman}/bin/podman pull "$image"
  #        done
  #      '');
  #    };
  #  };
}
