{
  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    matchBlocks = {
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
    };
  };
}
