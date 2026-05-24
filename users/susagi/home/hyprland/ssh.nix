{
  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    # addKeysToAgent = "yes";
    matchBlocks = {
      "*".addKeysToAgent = "yes";

      kitsunebi = {
        host = "nebi kitsunebi";
        # hostname = "192.168.178.178"; # ## previously .103
        hostname = "100.64.0.3";
        port = 2299;
        user = "neo";
        identityFile = "/home/susagi/.ssh/vde_rsa";
      };
      pi-sniffer = {
        host = "sni sniffer";
        hostname = "192.168.0.23"; # ## previously .103 + 100
        port = 22;
        user = "nixos"; # ##"susagi";
        identityFile = "/home/susagi/.ssh/vde_rsa";
      };

      rpi = {
        host = "kii kiichigo";
        hostname = "192.168.178.23";
        port = 2299;
        user = "susagi";
        identityFile = "/home/susagi/.ssh/vde_rsa";
      };

      x99 = {
        host = "x99 stfx99";
        hostname = "steffen.fail";
        port = 2299;
        user = "susagi";
        identityFile = "/home/susagi/.ssh/thinkpad_rsa";
      };

      futro = {
        host = "f futro";
        hostname = "negitorodon.de";
        port = 30715;
        user = "susagi";
        identityFile = "/home/susagi/.ssh/vde_rsa";
      };

      kyoujin = {
        host = "kyo kyoujin";
        hostname = "192.168.178.107";
        port = 2299;
        user = "susagi";
        identityFile = "/home/susagi/.ssh/vde_rsa";
      };
      aarch64-vm = {
        host = "vm arch64-vm";
        hostname = "localhost";
        port = 2222;
        user = "nixos";
        # identityFile = "/home/susagi/.ssh/vde_rsa";
      };
    };
  };
}
