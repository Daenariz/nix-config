{ config, ... }:

{
  sops.secrets.nextcloud = { };
  sops.secrets.tt-rss = { };

  sops.secrets.github-token = { };
  sops.templates.access-tokens.content = ''
    access-tokens = github.com=${config.sops.placeholder.github-token}
  '';
}
