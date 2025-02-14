{ pkgs, ... }:

with pkgs;

[
  # local.stm32cubeide
  # steam # now in host pkgs
  ollama
  tts
  portaudio
  aichat
  vlc
  jan
  signal-desktop
  thunderbird
  octaveFull
  zoom-us # SSO doesn't seem too work https://github.com/NixOS/nixpkgs/issues/73532 (?)
  whatsapp-for-linux
  parted
  #testing
  #vscodium
  vscode
]
