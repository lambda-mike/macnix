opts@{
  rev,
  dirtyRev,
  loginwindowText,
  user,
}:
{ pkgs, ... }:
{
  environment.systemPackages = [
  ];

  # Auto upgrade nix package
  # nix.package = pkgs.nix;

  nix.enable = false;
  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  environment.variables = {
    EDITOR = "hx";
  };

  fonts.packages = with pkgs; [
    jetbrains-mono
    nerd-fonts._3270
    nerd-fonts.agave
    nerd-fonts.hack
    nerd-fonts.cousine
    nerd-fonts.fira-mono
    nerd-fonts.hurmit
    nerd-fonts.iosevka
    nerd-fonts.mononoki
    nerd-fonts.roboto-mono
    nerd-fonts.sauce-code-pro
    nerd-fonts.terminess-ttf
    nerd-fonts.ubuntu-mono
  ];

  power.sleep.allowSleepByPowerButton = true;
  # power.sleep.computer = 30;
  power.sleep.display = 17;

  programs.bash.enable = true;
  programs.direnv.enable = true;
  programs.fish.enable = true;
  # programs.vim.enable = true;
  # programs.vim.enableSensible = true;
  # programs.zsh.enable = true;  # default shell on catalina

  system.defaults = {
    finder.AppleShowAllExtensions = true;
    finder.FXPreferredViewStyle = "clmv";
    loginwindow.LoginwindowText = loginwindowText;
    # services.prometheus.exporters.node.enable
    # ".GlobalPreferences"."com.apple.sound.beep.sound" = /System/Library/Sounds/;
    ActivityMonitor.IconType = 5;
    NSGlobalDomain.AppleInterfaceStyle = "Dark";
    # NSGlobalDomain.InitialKeyRepeat = 200;
    # NSGlobalDomain.KeyRepeat = 100;
    NSGlobalDomain.NSScrollAnimationEnabled = true;
    NSGlobalDomain.NSTableViewDefaultSizeMode = 2;
    NSGlobalDomain."com.apple.keyboard.fnState" = true;
    NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
    NSGlobalDomain."com.apple.swipescrolldirection" = false;
    WindowManager.EnableStandardClickToShowDesktop = true;
    # WindowManager.GloballyEnabled = true;
    controlcenter.BatteryShowPercentage = true;
    # dock.appswitcher-all-displays = true;
    dock.autohide = true;
    dock.mru-spaces = false;
    finder.ShowPathbar = true;
    finder.ShowStatusBar = true;
    magicmouse.MouseButtonMode = "TwoButton";
    menuExtraClock.Show24Hour = true;
    menuExtraClock.ShowDate = 0; # or 1
    screencapture.include-date = true;
    # screencapture.location = "/TODO";
    screensaver.askForPassword = true;
    screensaver.askForPasswordDelay = 7;
    trackpad.Dragging = true;
    trackpad.TrackpadRightClick = true;
    trackpad.TrackpadThreeFingerDrag = true;
  };
  system.keyboard.enableKeyMapping = true;
  # system.keyboard.swapLeftCtrlAndFn = true;

  # enable sudo auth via touch id
  security.pam.services.sudo_local.touchIdAuth = true;

  users.users.${user}.home = /. + builtins.toPath "/Users/${user}";

  # temporary until nix-darwin releases multi-user support out of the box
  system.primaryUser = user;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = opts.rev or opts.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
