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
  #  bitwarden-menu
  #  bitwarden-cli
  # dmenu

  ##  displaylink # for the proprietary displaylink driver
    #    matlab  ## I hate this piece of sh...
    #  bottles  ## for the piece of sh... above, but deprecated
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
    flatpak # for the binary
    thunderbird
    tidal-hifi
    signal-desktop
    ausweisapp
    #   whatsie
    #stable.whatsapp-for-linux # wasistlos=unstable, stable not working
    #   zoom-us # SSO doesn't seem too work https://github.com/NixOS/nixpkgs/issues/73532 (?)
  ]
