{
services.wyoming = {
  faster-whisper.servers = {
    testserver = {
      enable = true;
      uri = "tcp://0.0.0.0:10300";
      language = "auto";
    };
  };

  piper.servers = {
    testserver = {
      enable = true;
      uri = "tcp://0.0.0.0:10200";
      voice = "de_DE-thorsten-high";
    };
  };
};
}
