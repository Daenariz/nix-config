{
  inputs,
  config,
  outputs,
  ...
}:
{
  imports = [
    outputs.homeModules.nextcloud-sync
  ];

  services.nextcloud-sync = {
    enable = true;
    remote = "cloud.negitorodon.de";
    passwordFile = config.sops.secrets.nextcloud.path;
    connections = [
      {
        local = "${config.home.homeDirectory}/Music";
        remote = "/auds";
      }
      {
        local = "${config.home.homeDirectory}/Documents";
        remote = "/docs";
      }
      {
        local = "${config.home.homeDirectory}/Pictures";
        remote = "/pics";
      }
      {
        local = "${config.home.homeDirectory}/Videos";
        remote = "/vids";
      }
      {
        local = "${config.home.homeDirectory}/Desktop/stud";
        remote = "/stud";
      }
    ];
  };
}
