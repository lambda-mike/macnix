{ pkgs, ... }:
{
  bat = {
    enable = true;
    config = {
      pager = "less -FR";
      theme = "1337";
    };
  };
  bottom.enable = true;
  bun.enable = true;
  emacs.enable = true;
  eza = {
    enable = true;
    git = true;
    icons = "auto";
  };
  gpg.enable = true;
  jq.enable = true;
  nnn = {
    enable = true;
  };
  skim.enable = true;
  tealdeer.enable = true;
  zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = false;
  };
}
