{ user, helixTheme, theme, windowManager, stateVersion }:
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
    (import ./sage_xdg.nix theme)
    (import ./xsession.nix { inherit windowManager; })
  ];

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    packages = (with pkgs; [
      azure-cli
      brave
      cloudflared
      cryfs
      delta
      dust
      duf
      eslint
      fd
      font-awesome
      gimp
      # git-crypt
      glab
      julia
      krita
      libreoffice
      lsof
      neofetch
      nerd-fonts.agave
      nerd-fonts.caskaydia-cove
      nerd-fonts.cousine
      nerd-fonts.fira-mono
      nerd-fonts.hack
      nerd-fonts.hurmit
      nerd-fonts.iosevka
      nerd-fonts.jetbrains-mono
      nerd-fonts.monofur
      nerd-fonts.mononoki
      nerd-fonts.roboto-mono
      nerd-fonts.sauce-code-pro
      nerd-fonts.symbols-only
      nerd-fonts.terminess-ttf
      nerd-fonts.ubuntu-mono
      nil
      nixfmt
      nodePackages.nodejs
      pcloud
      perl
      perlnavigator
      pnpm
      python312
      # Python LSP
      # python312Packages.pylsp-mypy
      # python312Packages.pylsp-rope
      # python312Packages.python-lsp-ruff
      # python312Packages.python-lsp-server
      qrcode
      rustup
      screen
      scrot
      shellcheck
      symbola
      tokei
      tree
      typescript
      typescript-language-server
      unzip
      vscode-langservers-extracted
      xsel
    ]);
    file = import ./homeFile.nix { inherit config; };
    sessionPath = [
      "${config.home.homeDirectory}/.local/bin"
    ];
    sessionVariables = {
      # Other env vars here cause issues during fish shell startup
      EDITOR = "hx";
    };
    stateVersion = stateVersion;
  };

  fonts.fontconfig.enable = true;

  programs = import ./core/sage_programs.nix theme { inherit pkgs; } // {
    # Overwrite programs here
  };

  # FIXME create keys.nix
  # FIXME programs.git userName
  # FIXME programs.git userEmail
  # FIXME services/redshift.nix coords
  # FIXME sage_xdg.nix ~/wallpaper
}
