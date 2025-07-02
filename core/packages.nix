{ pkgs, ... }:

# let
  # sources = import ../nix/sources.nix;
  # nixpkgsUnstable = sources."nixpkgs-unstable";
  # pkgsUnstable = import nixpkgsUnstable {};
# in (with pkgs; [
(with pkgs; [
  # appimage-run
  # bandwhich
  # pkgsUnstable.bazecor
  brave
  # cmus
  # cryfs
  # dasel
  delta
  # docker
  du-dust
  duf
  fd
  file
  # font-awesome
  gimp
  # git-crypt
  # gnome.simple-scan
  # grex
  # i3lock
  julia
  # leftwm
  # libreoffice
  # lsof
  neofetch
  # (nerdfonts.override { fonts = [
  #   "Agave" "CascadiaCode" "Cousine" "FiraMono" "Hack" "Hermit" "Iosevka" "JetBrainsMono"
  #   "Monofur" "Mononoki" "RobotoMono" "SourceCodePro" "Terminus" "UbuntuMono"
  # ]; })
  # ncompress
  # nil
  nixfmt-classic
  # nnn
  nodePackages.eslint
  nodePackages.typescript-language-server
  # pciutils
  # pinentry
  # procs
  # python3
  # qrencode
  # qview
  ripgrep
  # rustup
  # scrot
  screen
  shellcheck
  tokei
  tree
  unzip
  # xfce.xfce4-terminal
  # xorg.xbacklight
  # xorg.xdpyinfo
  # xsel
  # zip
])
