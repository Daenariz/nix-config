{
  inputs,
  outputs,
  config,
  ...
}:
{
  imports = [
    outputs.nixosModules.forgejo
    outputs.nixosModules.forgejo-runner
  ];

  services.forgejo.enable = true;
  services.forgejo.stateDir = "/data/forgejo";

  services.forgejo-runner = {
    enable = true;
    url = config.services.forgejo.settings.server.ROOT_URL;
    tokenFile = config.sops.templates."forgejo_runner_token".path;
  };
}
