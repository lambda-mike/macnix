{ pkgs, ... }:

# let
  # sources = import ../nix/sources.nix;
  # nixpkgsUnstable = sources."nixpkgs-unstable";
  # pkgsUnstable = import nixpkgsUnstable {};
# in (with pkgs; [
(with pkgs; [
  # appimage-run
  # bandwhich
  # brave
  delta
  # docker
  du-dust
  duf
  fd
  # font-awesome
  # gimp
  # git-crypt
  # gnome.simple-scan
  # grex
  neofetch
  # (nerdfonts.override { fonts = [
  #   "Agave" "CascadiaCode" "Cousine" "FiraMono" "Hack" "Hermit" "Iosevka" "JetBrainsMono"
  #   "Monofur" "Mononoki" "RobotoMono" "SourceCodePro" "Terminus" "UbuntuMono"
  # ]; })
  # ncompress
  nil
  nixfmt-classic
  # nnn
  # nodePackages.eslint
  # nodePackages.typescript-language-server
  # procs
  # python3
  # qrencode
  # qview
  ripgrep
  # rustup
  screen
  shellcheck
  tokei
  # tree
])
