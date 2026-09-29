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

    instances.sciebo = {
      username = "deckert@th-koeln.de";
      remote = "th-koeln.sciebo.de";
      passwordFile = config.sops.secrets.sciebo.path;
      connections = [
        {
          local = "/home/susagi/Documents/kokushi";
          remote = "/Kokushi_Orga";
        }
      ];
    };
  };
}
