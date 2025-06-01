{ pkgs, ... }:

with pkgs;

[
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
    tidal-hifi # TODO: need to check autostart, crashing

    #  bitwarden-cli
    #   bitwarden-desktop
    bitwarden-menu
    # github stuff
  ]
++
  # essentials
  [
    steam
    signal-desktop
    #stable.whatsapp-for-linux #no unstable, stable not working
    #    zoom-us # SSO doesn't seem too work https://github.com/NixOS/nixpkgs/issues/73532 (?)
  ]
