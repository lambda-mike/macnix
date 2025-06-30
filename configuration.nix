opts@{ rev ? false, dirtyRev ? false }:
{ pkgs, ... }: {
  environment.systemPackages = [
    pkgs.vim
  ];

  # Auto upgrade nix package 
  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  dock.autohide = true;
  dock.mru-spaces = true;
  finder.AppleShowAllExtensions = true;
  finder.FXPreferredViewStyle = "clmv";
  loginwindow.LoginwindowText = builtins.abort "TODO LoginwindowText";
  programs.bash.enable = true;
  programs.fish.enable = true;
  # programs.zsh.enable = true;  # default shell on catalina
  screencapture.location = "~/Pictures/screenshots";
  screensaver.askForPasswordDelay = 7;

  # enable sudo auth via touch id
  # security.pam.services.sudo_local.touchIdAuth = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = opts.rev or opts.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
