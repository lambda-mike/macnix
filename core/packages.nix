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
  font-awesome
  # gimp
  # git-crypt
  # grex
  neofetch
  nil
  nixfmt-classic
  # nnn
  nodePackages.eslint
  nodePackages.typescript-language-server
  # procs
  # python3
  # qrencode
  # qview
  ripgrep
  # rustup
  screen
  shellcheck
  tokei
])
