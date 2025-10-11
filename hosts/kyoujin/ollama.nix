{ config, inputs, lib, ... }:
{
  imports = [
    #inputs.core.nixosModules.open-webui
  ];
  services.ollama = {
    enable = true;
    host = "0.0.0.0";
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

  # services.open-webui = {
  #enable = true;
  #openFirewall = true;
  #host = "0.0.0.0";
#  environment = {
#   "BYPASS_MODEL_ACCESS_CONTROL" = "False";
#    "USER_PERMISSIONS_WORKSPACE_KNOWLEDGE_ACCESS" = "False";
#    "USER_PERMISSIONS_WORKSPACE_MODELS_ACCESS" = "False";
#    "USER_PERMISSIONS_WORKSPACE_PROMPTS_ACCESS" = "False";
#    "USER_PERMISSIONS_WORKSPACE_TOOLS_ACCESS" = "False";
#  };
  #};

}
