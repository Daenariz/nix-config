{
  inputs,
  config,
  ...
}:

{
  imports = [
    inputs.core.homeModules.nextcloud-sync
  ];

  services.nextcloud-sync = {
    enable = true;
    remote = "cloud.negitorodon.de";
    passwordFile = config.sops.secrets.nextcloud.path;
    connections = [
      {
        local = "/home/susagi/Music";
        remote = "/auds";
      }
      {
        local = "/home/susagi/Documents";
        remote = "/docs";
      }
      {
        local = "/home/susagi/Pictures";
        remote = "/pics";
      }
      {
        local = "/home/susagi/Videos";
        remote = "/vids";
      }
      {
        local = "/home/susagi/Desktop/stud";
        remote = "/stud";
      }
    ];
  };

}
