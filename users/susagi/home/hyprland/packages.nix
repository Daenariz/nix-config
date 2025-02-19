{ pkgs, ... }:

with pkgs;

[
  # local.stm32cubeide
  # portaudio
  ausweisapp
  vlc
  octaveFull
]
++
  # ai stuff
  [
    tts
    ollama
    aichat
    jan
  ]
++
  # testing
  [
    #vscodium
    unstable.spotube
    vscode
  ]
++
  # essentials
  [
    thunderbird
    signal-desktop
    whatsapp-for-linux
    zoom-us # SSO doesn't seem too work https://github.com/NixOS/nixpkgs/issues/73532 (?)

  ]
