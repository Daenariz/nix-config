{
  pkgs,
  config,
  ...
}: {
  sops.secrets."email_username" = {};
  sops.secrets."email_password" = {};

  home.packages = with pkgs; [
    sieve-connect
    # helper script
    (writeScriptBin "upload-mailsieve" ''
      #!/bin/bash
      USER=$(cat ${config.sops.secrets.email_username.path})
      PASS=$(cat ${config.sops.secrets.email_password.path})


      echo "Uploading sieve-script to hetzner..."
      ${pkgs.sieve-connect}/bin/sieve-connect \
        --server mail.your-server.de \
        --user "$USER" \
        --password "$PASS" \
        --upload ${./modules/mail/filters.sieve}
    '')
  ];

  # Das Sieve-Skript auch als Datei verlinken (für die Übersicht)
  home.file.".config/sieve/master.sieve".source = ./modules/mail/filters.sieve;
}
