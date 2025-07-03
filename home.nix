{ blockedBranch, user }:
{ config, pkgs, ... }:

{
  imports = [
    ./programs/alacritty.nix
    ./programs/fish.nix
    (import ./programs/git.nix { inherit blockedBranch; })
    # ./programs/keychain.nix
    # ./programs/ssh.nix
    ./programs/tmux.nix
    # ./services/gpg-agent.nix
  ];

  home = {
    username = user;
    # file = import ./homeFile.nix { inherit config; };
    packages = import ./core/packages.nix { inherit pkgs; } ++ (with pkgs; [
    ]);
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

  # FIXME create keys.nix
  # FIXME programs.git.userName
  # FIXME programs.git.userEmail
}
