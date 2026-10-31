{
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.services.nextcloud-sync;
  syncScript = pkgs.writeShellScript "_nextcloud-sync" ''
    LOCAL=$1
    REMOTE=$2
    PFILE=$3
    USERNAME=$4
    SERVER=$5
    PASSWORD=$(${pkgs.coreutils}/bin/cat $PFILE)
    if [ -z $PASSWORD ]; then
      ${pkgs.libnotify}/bin/notify-send "Nextcloud Sync Error" "No password found in $PFILE"
      exit 1
    fi
    ${pkgs.coreutils}/bin/mkdir -p $LOCAL
    ${pkgs.nextcloud-client}/bin/nextcloudcmd -h -n --path $REMOTE --user "$USERNAME" --password "$PASSWORD" $LOCAL https://$SERVER
    ${pkgs.libnotify}/bin/notify-send "Nextcloud Sync" "Synced $LOCAL with $REMOTE"
  '';

  instanceSubmodule = { ... }: {
    options = {
      username = lib.mkOption {
        type = lib.types.str;
        default = config.home.username;
        description = "Username for Nextcloud authentication.";
      };
      passwordFile = lib.mkOption {
        type = lib.types.path;
        description = "File containing only Nextcloud password for this instance.";
      };
      remote = lib.mkOption {
        type = lib.types.str;
        example = "nextcloud.example.com";
        description = "The remote Nextcloud server domain name.";
      };
      initTimer = lib.mkOption {
        type = lib.types.str;
        default = "1min";
        description = "The time to wait after booting up before starting the sync services.";
      };
      rerunTimer = lib.mkOption {
        type = lib.types.str;
        default = "20min";
        description = "The time to wait before rerunning the sync services.";
      };
      connections = lib.mkOption {
        type = lib.types.listOf (
          lib.types.submodule {
            options = {
              local = lib.mkOption {
                type = lib.types.str;
                description = "The local directory path to sync.";
              };
              remote = lib.mkOption {
                type = lib.types.str;
                description = "The remote directory path in Nextcloud.";
              };
            };
          }
        );
        default = [ ];
        description = "A list of sync connections for this instance.";
      };
    };
  };

  # Merge flat config + named instances into one uniform attrset
  allInstances =
    (lib.optionalAttrs (cfg.connections != [ ] && cfg.passwordFile != null && cfg.remote != null) {
      default = {
        username = cfg.username;
        passwordFile = cfg.passwordFile;
        remote = cfg.remote;
        initTimer = cfg.initTimer;
        rerunTimer = cfg.rerunTimer;
        connections = cfg.connections;
      };
    })
    // cfg.instances;

  # Service prefix: "default" instance keeps old naming for backward compat
  servicePrefix = name:
    if name == "default" then "nextcloud-sync" else "nextcloud-sync-${name}";

  makeUserServices = acc: instanceName:
    let
      inst = allInstances.${instanceName};
      prefix = servicePrefix instanceName;
    in
    lib.foldl' (
      acc2: dir:
      acc2
      // {
        "${prefix}-${builtins.baseNameOf dir.local}" = {
          Unit = {
            Description = "Auto sync Nextcloud [${instanceName}]: ${dir.local} <-> ${dir.remote}";
            After = "network-online.target";
            ConditionPathExists = inst.passwordFile;
          };
          Service = {
            Type = "simple";
            ExecStart = "${syncScript} ${dir.local} ${dir.remote} ${inst.passwordFile} ${inst.username} ${inst.remote}";
            TimeoutStopSec = "180";
            KillMode = "process";
            KillSignal = "SIGINT";
          };
          Install.WantedBy = [ "default.target" ];
        };
      }
    ) acc inst.connections;

  makeUserTimers = acc: instanceName:
    let
      inst = allInstances.${instanceName};
      prefix = servicePrefix instanceName;
    in
    lib.foldl' (
      acc2: dir:
      acc2
      // {
        "${prefix}-${builtins.baseNameOf dir.local}" = {
          Unit.Description = "Nextcloud sync timer [${instanceName}].";
          Timer = {
            OnBootSec = inst.initTimer;
            OnUnitActiveSec = inst.rerunTimer;
          };
          Install.WantedBy = [
            "multi-user.target"
            "timers.target"
          ];
        };
      }
    ) acc inst.connections;

  allServiceNames = builtins.concatMap (instanceName:
    let
      inst = allInstances.${instanceName};
      prefix = servicePrefix instanceName;
    in
    builtins.map (dir: "${prefix}-${builtins.baseNameOf dir.local}") inst.connections
  ) (builtins.attrNames allInstances);

  manualSyncScript = pkgs.writeShellScriptBin "nextcloud-sync-all" ''
    set -e
    ${pkgs.libnotify}/bin/notify-send "Nextcloud Manual Sync" "Starting manual sync of all configured directories."
    SERVICES=(${lib.escapeShellArgs allServiceNames})
    for svc in "''${SERVICES[@]}"; do
      echo "Starting sync service: $svc"
      systemctl --user start "$svc"
    done
  '';

  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    types
    ;
in
{
  options.services.nextcloud-sync = {
    enable = mkEnableOption "Nextcloud sync systemd services via nextcloudcmd.";
    username = mkOption {
      type = types.str;
      default = config.home.username;
      description = "Username for Nextcloud authentication (flat/default config).";
    };
    passwordFile = mkOption {
      type = types.nullOr types.path;
      default = null;
      description = "File containing only Nextcloud password (flat/default config).";
    };
    remote = mkOption {
      type = types.nullOr types.str;
      default = null;
      example = "nextcloud.example.com";
      description = "The remote Nextcloud server domain name (flat/default config).";
    };
    initTimer = mkOption {
      type = types.str;
      default = "1min";
      description = "The time to wait after booting up before starting the sync services (flat config).";
    };
    rerunTimer = mkOption {
      type = types.str;
      default = "20min";
      description = "The time to wait before rerunning the sync services (flat config).";
    };
    connections = mkOption {
      type = types.listOf (
        types.submodule {
          options = {
            local = mkOption {
              type = types.str;
              description = "The local directory path to sync.";
            };
            remote = mkOption {
              type = types.str;
              description = "The remote directory path in Nextcloud.";
            };
          };
        }
      );
      default = [ ];
      description = "A list of sync connections (flat/default config).";
    };
    instances = mkOption {
      type = types.attrsOf (types.submodule instanceSubmodule);
      default = { };
      description = "Named Nextcloud sync instances. Each instance gets its own credentials, remote, and connections.";
      example = lib.literalExpression ''
        {
          sciebo = {
            username = "myUser";
            remote = "th-koeln.sciebo.de";
            passwordFile = config.sops.secrets.sciebo.path;
            connections = [
              { local = "/home/user/Uni"; remote = "/Kokushi_Orga"; }
            ];
          };
        }
      '';
    };
  };

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.libnotify
      manualSyncScript
    ];

    systemd.user.services = lib.foldl' makeUserServices { } (builtins.attrNames allInstances);
    systemd.user.timers = lib.foldl' makeUserTimers { } (builtins.attrNames allInstances);
  };
}
