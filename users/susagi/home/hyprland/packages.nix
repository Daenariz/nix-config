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
  #  tts
  #  ollama
  #  aichat
  #    jan
  ]
++
  #　たいせつな日本語の勉強
  [
    tagainijisho # タガイニ辞書
    anki
    tango
    noto-fonts-cjk-sans # ファイアフォックスでは、日本語のかなを見せるのために
  ]
++
  # testing
  [
    #vscodium
    #unstable.spotube
  ##    vscode
    rpi-imager
    core-dev.plecs
    tidal-hifi  # TODO: need to check autostart, crashing
    platformio
    esptool

  #  bitwarden-cli
  #   bitwarden-desktop
    bitwarden-menu
  # github stuff
    cpplint
    act
    docker
  ]
++
  # essentials
  [
    thunderbird
    signal-desktop
  #stable.whatsapp-for-linux #no unstable, stable not working
  #    zoom-us # SSO doesn't seem too work https://github.com/NixOS/nixpkgs/issues/73532 (?)
  ]
