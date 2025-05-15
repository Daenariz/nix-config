{ pkgs, ... }:

with pkgs;

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
    # vscodium
    #unstable.spotube
    # vscode
  # bitwarden-cli bitwarden-desktop bitwarden-menu
  ]
++
  # dev
  [
    rpi-imager
    core-dev.plecs
    platformio
    esptool
    octaveFull
  ]
++
  # essentials
  [
    thunderbird
    tidal-hifi 
    signal-desktop
    ausweisapp
  #   whatsie
  #stable.whatsapp-for-linux # wasistlos=unstable, stable not working
  #   zoom-us # SSO doesn't seem too work https://github.com/NixOS/nixpkgs/issues/73532 (?)
  ]
