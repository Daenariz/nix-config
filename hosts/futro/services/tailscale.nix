{
  config,
  inputs,
  ...
}:
{
  imports = [
    inputs.synix.nixosModules.tailscale
  ];

  services.tailscale = {
    enable = true;
    tailnets = {
      personal = {
        loginServer = "https://head.${config.networking.domain}";
        authKeyFile = config.sops.secrets."tailscale/auth-key".path;
        enableSSH = true;
      };
    };
  };
}
