let
  enableWyoming = true;
in
{
  services.wyoming = {
    faster-whisper.servers = {
      testserver = {
        enable = enableWyoming;
	model = "small-int8";
	device = "cuda";
        uri = "tcp://0.0.0.0:10300";
        language = "de";
      };
    };

    piper.servers = {
      testserver = {
        enable = enableWyoming;
        uri = "tcp://0.0.0.0:10200";
        voice = "de_DE-thorsten-low";
      };
    };
  };
}
