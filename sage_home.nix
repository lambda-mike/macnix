{ user, helixTheme, theme, windowManager }:
{ pkgs, config, ... }:

{

  # The home-manager manual is at:
  #
  #   https://rycee.gitlab.io/home-manager/release-notes.html
  #
  # Configuration options are documented at:
  #
  #   https://rycee.gitlab.io/home-manager/options.html

  imports = [
    ./cursor.nix
    ./programs/alacritty.nix
    ./programs/fish.nix
    ./programs/git.nix
    (import ./programs/helix.nix { theme = helixTheme; })
    ./programs/keychain.nix
    ./programs/tmux.nix
    ./services/gpg-agent.nix
    ./services/redshift.nix
    ./services/screen-locker.nix
    (import ./services/polybar.nix { inherit theme windowManager; })
    (import ./xdg.nix theme)
    (import ./xsession.nix { inherit windowManager; })
  ];

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    packages = (with pkgs; [
      azure-cli
      cloudflared
      delta
      dust
      duf
      eslint
      fd
      font-awesome
      gh
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
      rustup
      screen
      shellcheck
      tokei
      typescript
      typescript-language-server
      vscode-langservers-extracted
    ]);
    file = import ./homeFile.nix { inherit config; };
    sessionPath = [
      "${config.home.homeDirectory}/.local/bin"
    ];
    sessionVariables = {
      # Other env vars here cause issues during fish shell startup
      EDITOR = "hx";
    };
    stateVersion = "25.05";
  };

  fonts.fontconfig.enable = true;

  programs = import ./core/sage_programs.nix theme { inherit pkgs; } // {
    # Overwrite programs here
  };
}
