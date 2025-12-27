{ pkgs, ... }:

with pkgs;

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
    keepass
    joplin-cli
    tor-browser
    #  vmware-workstation
    ##  displaylink # for the proprietary displaylink driver
    #    matlab  ## I hate this piece of sh...
    #  bottles  ## for the piece of sh... above, but deprecated
    # monero-gui
    texliveFull
    texstudio
  ]
++
  # dev
  [
    rpi-imager
    local.plecs
    platformio
    esptool
    octaveFull
  ]
++
  # essentials
  [
    brave
    teams-for-linux
    flatpak # for the binary
    thunderbird
    tidal-hifi
    ausweisapp
    vlc
    zoom-us
  ]
++
  # fun
  [
    nmap
    metasploit
    netdiscover
    theharvester
  ]
