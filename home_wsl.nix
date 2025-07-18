{ user, helixTheme }:
{ config, pkgs, ... }:

{
  imports = [
    ./programs/fish.nix
    (import ./programs/helix.nix { theme = helixTheme; })
    ./programs/git.nix
    # ./programs/keychain.nix
    ./programs/ssh.nix
    ./programs/tmux.nix
    # ./services/gpg-agent.nix
    ./xdg.nix
  ];

  home = {
    username = user;
    # file = import ./homeFile.nix { inherit config; };
    packages = (
      with pkgs;
      [
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
        ripgrep
        rustup
        screen
        shellcheck
        tokei
        typescript
        typescript-language-server
        vscode-langservers-extracted
      ]
    );
    sessionVariables = {
      # Other env vars here cause issues during fish shell startup
      EDITOR = "hx";
    };
    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "25.05";
  };

  programs = import ./core/programs.nix { inherit pkgs; } // {
    # Overwrite programs here
    # Let Home Manager install and manage itself.
    home-manager.enable = true;
  };

  # FIXME programs.git.userName
  # FIXME programs.git.userEmail
}
