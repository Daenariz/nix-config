{ pkgs, ... }:

with pkgs;

[
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
    tagainijisho
    anki
    rpi-imager
    tango
    core-dev.plecs
    tidal-dl
    tidal-hifi
  ]
++
  # essentials
  [
    noto-fonts-cjk-sans # important for displaying japanese kana on firefox browser or just in general
    thunderbird
    signal-desktop
    whatsapp-for-linux
    zoom-us # SSO doesn't seem too work https://github.com/NixOS/nixpkgs/issues/73532 (?)
  ]
