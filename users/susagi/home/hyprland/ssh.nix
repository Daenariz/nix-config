{
  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    matchBlocks = {

      pi-sniffer = {
        host = "sni sniffer";
        hostname = "192.168.0.103";
        port = 22;
        user = "pi";
        identityFile = "/home/susagi/.ssh/vde_rsa";
      };

      rpi = {
        host = "kii kiichigo";
        hostname = "negitorodon.de";
        port = 3407;
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
        identityFile = "/home/susagi/.ssh/tp_dev";
      };

      kyoujin = {
        host = "kyo kyoujin";
        hostname = "negitorodon.de";
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
