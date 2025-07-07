{ pkgs, ... }:

# let
  # sources = import ../nix/sources.nix;
  # nixpkgsUnstable = sources."nixpkgs-unstable";
  # pkgsUnstable = import nixpkgsUnstable {};
# in (with pkgs; [
(with pkgs; [
  # bandwhich
  # brave
  delta
  du-dust
  duf
  fd
  font-awesome
  # gimp
  git-crypt
  # grex
  neofetch
  nil
  nixfmt-classic
  # nnn
  nodePackages.eslint
  nodePackages.typescript-language-server
  pnpm
  # procs
  # python3
  # qrencode
  ripgrep
  # rustup
  screen
  shellcheck
  tokei
])
