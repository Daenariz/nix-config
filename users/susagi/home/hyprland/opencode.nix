{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) getExe;
in
{
  programs = {
    opencode = {
      enable = true;
      enableMcpIntegration = config.programs.mcp.enable;
      settings = {
        autoshare = false;
        autoupdate = false;
        permission = {
          external_directory = {
            "/nix/store/**" = "allow";
          };
        };
        model = "deepseek/deepseek-v4-pro";
        provider = {
          openrouter = {
            name = "Openrouter";
            # npm = "@ai-sdk/openai-compatible";
            options = {
              baseURL = "https://openrouter.ai/api/v1";
              apiKey = "{env:OPENROUTER_KEY}";
            };
            models = {
              "deepseek/deepseek-v4-flash" = {
                name = "DeepSeek V4 Flash";
                tool_call = true;
              };
              "deepseek/deepseek-v4-pro" = {
                name = "DeepSeek V4 Pro";
                tool_call = true;
              };
            };
          };
          gwdg = {

            name = "GWDG";
            # npm = "@ai-sdk/openai-compatible";
            options = {
              baseURL = "https://chat-ai.academiccloud.de/v1";
              apiKey = "{env:GWDG_KEY}";
            };
            models = {
              "qwen3.6-27b" = {
                name = "Qwen 3.6 27B";
                tool_call = true;
              };
            };
          };
        };
      };
    };

    mcp = {
      enable = true;
      servers = {
        # embedded-debugger = {
        #   command = getExe pkgs.synix.embedded-debugger-mcp;
        #   env = {
        #     RUST_LOG = "info";
        #   };
        # };
        # forgejo = {
        #   command = getExe pkgs.forgejo-mcp;
        #   args = [
        #     "--transport"
        #     "stdio"
        #     "--url"
        #     "https://git.sid.ovh"
        #   ];
        #   env = {
        #     FORGEJO_USER_AGENT = "forgejo-mcp/1.0.0";
        #   };
        #   envFile = config.sops.templates.forgejo-mcp-env-file.path;
        # };
        nixos = {
          command = getExe pkgs.mcp-nixos;
        };
        playwright = {
          command = getExe pkgs.playwright-mcp;
          args = [
            "--headless"
            "--user-data-dir"
            "${config.xdg.cacheHome}/playwright-mcp"
          ];
        };
        searx = {
          command = getExe pkgs.synix.mcp-searxng;
          env = {
            SEARXNG_URL = "https://srx.sid.ovh";
          };
        };
      };
    };

    zsh.initContent = ''
      source ${config.sops.templates.openrouter-env.path}
      source ${config.sops.templates.gwdg-env.path}
    '';
  };

  sops = {
    secrets.openrouter-api-key = { };
    templates.openrouter-env.content = ''
      export OPENROUTER_KEY=${config.sops.placeholder.openrouter-api-key}
    '';

    secrets.gwdg-api-key = { };
    templates.gwdg-env.content = ''
      export GWDG_KEY=${config.sops.placeholder.gwdg-api-key}
    '';

    # secrets.-api-key = { };
    # templates.requesty-env.content = ''
    #   export REQUESTY_API_KEY=${config.sops.placeholder.requesty-api-key}
    # '';

    # secrets.forgejo-mcp-access-token = { };
    # templates.forgejo-mcp-env-file.content = ''
    #   FORGEJO_ACCESS_TOKEN=${config.sops.placeholder.forgejo-mcp-access-token}
    # '';
  };
}
