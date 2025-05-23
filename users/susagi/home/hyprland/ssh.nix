{
  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
        matchBlocks = {
     negitorodon = {
       host = "n negito";
       hostname = "negitorodon.de";
       port = 3407;
       user = "susagi";
       identityFile = "/home/susagi/.ssh/vde_rsa";
     };
     };
  };
}
