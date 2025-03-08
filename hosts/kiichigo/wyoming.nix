{
services.wyoming = {
  faster-whisper.servers = {
    testserver = {
      enable = true;
      uri = "tcp://0.0.0.0:10300";
      language = "auto";
    };
  };
};
}
