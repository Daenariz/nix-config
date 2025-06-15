{ config, inputs, ...}:
{
imports = [
 inputs.core.nixosModules.open-webui
];
services.ollama = {
  enable = true;
  # Optional: preload models, see https://ollama.com/library
  loadModels = [ "llama3.2:3b" "deepseek-r1:1.5b"];
  acceleration = "cuda";
};

services.open-webui.enable = true;

}
