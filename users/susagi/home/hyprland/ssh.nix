{
  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    # addKeysToAgent = "yes";
    matchBlocks = {
      "*".addKeysToAgent = "yes";

      age-tutor = {
        host = "age age-tutor";
        hostname = "46.62.203.20";
        port = 42067;
        user = "admin";
        identityFile = "/home/susagi/.ssh/vde_rsa";
      };
      hetzner-edge = {
        host = "hetzner edge";
        hostname = "65.109.131.81";
        port = 2299;
        user = "susagi";
        identityFile = "/home/susagi/.ssh/vde_rsa";
      };
      kitsunebi = {
        host = "nebi kitsunebi";
        # hostname = "192.168.178.178"; # ## previously .103
        hostname = "100.64.0.3"; # deprec.
        port = 2299;
        user = "neo";
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

      futro-local = {
        host = "f futro";
        hostname = "192.168.178.99";
        port = 30715;
        user = "susagi";
        identityFile = "/home/susagi/.ssh/vde_rsa";
      };
      futro-tail = {
        host = "f-tail futro-tail";
        hostname = "100.64.0.3";
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
