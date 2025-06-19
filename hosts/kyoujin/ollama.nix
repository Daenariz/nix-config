{ config, inputs, ... }:
{
  imports = [
    inputs.core.nixosModules.open-webui
  ];
  services.ollama = {
    enable = true;
    openFirewall = true;
    # Optional: preload models, see https://ollama.com/library
    loadModels = [
      "llama3.1:8b"
      "llama3.2:3b"
      "qwen3:30b-a3b" # 3b active parameters
      "deepseek-r1:1.5b"
      "deepseek-r1:8b"
    ];
    acceleration = "cuda";
  };

  services.open-webui.enable = true;

}
