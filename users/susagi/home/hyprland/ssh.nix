{
  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    matchBlocks = {
      rpi = {
        host = "n negito";
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
        identityFile = "/home/susagi/.ssh/vde_rsa";
      };

      futro = {
        host = "f futro";
        hostname = "negitorodon.de";
        port = 30715;
        user = "susagi";
        identityFile = "/home/susagi/.ssh/tp_dev";
      };
    };

  };
}
