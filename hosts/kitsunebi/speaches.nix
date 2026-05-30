{
  virtualisation.oci-containers.containers."speaches" = {
    image = "ghcr.io/speaches-ai/speaches:latest"; # Prüfe ggf. das Tag für CUDA
    ports = ["8000:8000"];
    extraOptions = ["--gpus=all"];
    environment = {
      # STT Einstellungen
      "WHISPER_MODEL" = "base";
      "DEVICE" = "cuda";

      # TTS Einstellungen (Piper)
      "TTS_ENGINE" = "piper";
      "PIPER_VOICE" = "de-DE-thorsten-medium";
    };
  };

  networking.firewall.allowedTCPPorts = [8000];
}
