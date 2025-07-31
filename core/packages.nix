{ pkgs, ... }:
(with pkgs; [
  azure-cli
  delta
  du-dust
  duf
  eslint
  fd
  font-awesome
  git-crypt
  glab
  neofetch
  nil
  nixfmt-classic
  nodePackages.nodejs
  pnpm
  # Python LSP
  python312Packages.pylsp-mypy
  python312Packages.pylsp-rope
  python312Packages.python-lsp-ruff
  python312Packages.python-lsp-server
  ripgrep
  rustup
  screen
  shellcheck
  tokei
  typescript
  typescript-language-server
  vscode-langservers-extracted
])
