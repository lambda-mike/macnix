{ config, pkgs, ... }:
{
  bash = {
    enable = true;
    bashrcExtra = ''
      export SHELL="${pkgs.bash}/bin/bash"
    '';
  };
  bottom.enable = true;
  eza = {
    enable = true;
    git = true;
    icons = "auto";
  };
  fastfetch.enable = true;
  firefox.enable = true;
  firefox.configPath = "${config.xdg.configHome}/mozilla/firefox";
}
