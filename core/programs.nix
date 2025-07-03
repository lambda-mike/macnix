{ pkgs, ... }:
{
  # bash = {
  #   enable = true;
  #   bashrcExtra = ''
  #     export SHELL="${pkgs.bash}/bin/bash"
  #   '';
  # };
  bat = {
    enable = true;
    config = { pager = "less -FR"; theme = "1337"; };
  };
  bottom.enable = true;
  # broot.enable = true;
  # chromium.enable = true;
  # emacs.enable = true;
  eza = {
    enable = true;
    git = true;
    icons = "auto";
  };
  # gpg.enable = true;
  helix = import ./helix.nix;
  jq.enable = true;
  skim.enable = true;
  # tealdeer.enable = true;
  # vscode.enable = true;
  # zellij.enable = true;
  zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = false;
  };
}
