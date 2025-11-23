{ config, pkgs, inputs, lib, ... }:
{
  imports = [
    #inputs.core.nixosModules.open-webui
#    inputs.nixified-ai.nixosModules.comfyui
     inputs.core.nixosModules.open-webui-oci
  ];

  services.open-webui-oci.enable = true;
  services.open-webui-oci.enableSignUp = true;

  services.ollama = {
    enable = true;
    host = "0.0.0.0";
    openFirewall = true;
    # Optional: preload models, see https://ollama.com/library
    loadModels = [
      "llama3.2:3b"
      "qwen3:30b-a3b" # 3b active parameters
      "deepseek-r1:1.5b"
    ];
    acceleration = "cuda";
  };

  
#services.comfyui = {
#    enable = false;
#    package = inputs.nixified-ai.packages.${pkgs.system}.comfyui-nvidia; # package in overlay?
#    user = "comfyui";
 #   group = "comfyui";
#    host = "192.168.178.107";
#    extraFlags = [
#    "--lowvram"
#    ];
#    openFirewall = true;
#    acceleration = "cuda";
##    port = 8187;
#    customNodes = with pkgs.comfyuiPackages; [
#      comfyui-gguf
#      comfyui-impact-pack
#      comfyui-workflow-templates
#      comfyui-advanced-controlnet
#      comfyui-easy-use
#      comfyui-essentials
#    ];
#    models = with pkgs.nixified-ai.models; [
#    flux1-dev-q4_0 
#    (pkgs.fetchair {
#                name = "realvisxlV50_v50LightningBakedvae.safetensors";
#                air = "urn:air:sdxl:checkpoint:civitai:139562@798204";
#                sha256 = "FABCADD9330DCC4F9702063428D40B9D4D07168D8ACEFC819B8D1D9DB466B3EC";
#                passthru = {
#                  comfyui.installPaths = [ "checkpoints" ];
#                };
#              })];
#  };

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
