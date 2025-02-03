{ config, ... }:

let
  sops = config.sops;
in
{
  sops.templates.rclone.path = config.xdg.configHome + "/rclone/rclone.conf";
  sops.templates.rclone.content = ''
    [sciebo]
    type = webdav
    url = ${sops.placeholder."rclone/sciebo/url"}
    vendor = owncloud
    user = ${sops.placeholder."rclone/sciebo/user"}
    pass = ${sops.placeholder."rclone/sciebo/pass"}
  '';

  sops.secrets."rclone/sciebo/pass" = { };
  sops.secrets."rclone/sciebo/url" = { };
  sops.secrets."rclone/sciebo/user" = { };
}
