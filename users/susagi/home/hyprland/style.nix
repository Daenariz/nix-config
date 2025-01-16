{ config, ... }:

let
  colors = config.lib.stylix.colors.withHashtag;
in
''
  * {
    border: none;
    border-radius: 0;
    min-height: 5px;
    font-family: monospace;
    font-size: 15px;
  }

  window#waybar {
    background: transparent;
  }

  window#waybar.hidden {
    opacity: 0.2;
  }

  #workspaces {
    margin-right: 8px;
    border-radius: 8px;     /*look*/
    transition: none;
    background: ${colors.base01};
  }

  #workspaces button {
    transition: none;
    color: ${colors.base05};
    background: transparent;
    padding: 3px;
    /*font-size: 15px;*/
  }

  #workspaces button.active {
    color: ${colors.base0D};
  }

  #workspaces button:hover {
    transition: none;
    box-shadow: inherit;
    text-shadow: inherit;
    border-radius: inherit;
    color: ${colors.base00};
    background: ${colors.base02};
  }

  #cpu, #memory, #network, #battery, #keyboard-state, #disk, #bluetooth, #wireplumber, #language {
    margin-right: 5px;     /*already used in home-manager/waybar/default.nix*/
    /*padding-left: 5px;      look*/
    /*padding-right: 5px;      look*/
    padding: 3px;
    border-radius: 10px;
    transition: none;
    color: ${colors.base05};
    background: ${colors.base01};
  }

  #clock {
    border-radius: 10px 0px 0px 10px;
    /*padding-left: 10px;      look*/
    /*padding-right: 10px;      look*/
    padding: 3px;
    border-radius: 10px;
    transition: none;
    color: ${colors.base05};
    background: ${colors.base01};
  }

  #tray {
    padding-left: 20px;       /*look*/
    padding-right: 20px;      /*look*/
    border-radius: 10px;
    transition: none;
    color: ${colors.base05};
    background: ${colors.base01};
  }

  #keyboard-state label {
    color: ${colors.base05};
  }

  #keyboard-state label.locked {
    color: ${colors.base0D};
  }

  #battery.charging {
    background-color: ${colors.base0A};
  }

  #battery.warning:not(.charging) {
    background-color: ${colors.base0B};
    color: ${colors.base00};
  }

  #battery.critical:not(.charging) {
    background-color: ${colors.base08};
    color: ${colors.base07};
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
  }

  @keyframes blink {
    to {
      background-color: ${colors.base07};
      color: ${colors.base00};
    }
  }
''
