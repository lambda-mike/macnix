opts@{ rev, dirtyRev, loginwindowText }:
{ pkgs, ... }: {
  environment.systemPackages = [
    pkgs.vim
  ];

  # Auto upgrade nix package 
  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # environment.variables
  # fonts.packages
  # power.sleep.allowSleepByPowerButton = true;
  # power.sleep.computer = 10;
  # power.sleep.display = 7;

  dock.autohide = true;
  dock.mru-spaces = true;
  finder.AppleShowAllExtensions = true;
  finder.FXPreferredViewStyle = "clmv";
  loginwindow.LoginwindowText = loginwindowText;
  programs.bash.enable = true;
  # programs.direnv.enable = true;
  programs.fish.enable = true;
  # programs.vim.enable = enable;
  # programs.vim.enableSensible = true;
  # programs.zsh.enable = true;  # default shell on catalina
  screencapture.location = "~/Pictures/screenshots";
  screensaver.askForPasswordDelay = 7;
  # services.prometheus.exporters.node.enable
  # system.defaults.".GlobalPreferences"."com.apple.sound.beep.sound" = /System/Library/Sounds/;
  # system.defaults.ActivityMonitor.IconType = 5;
  # system.defaults.NSGlobalDomain.AppleInterfaceStyle = "Dark";
  # system.defaults.NSGlobalDomain.InitialKeyRepeat = 200;
  # system.defaults.NSGlobalDomain.KeyRepeat = 100;
  # system.defaults.NSGlobalDomain.NSScrollAnimationEnabled = true;
  # system.defaults.NSGlobalDomain.NSTableViewDefaultSizeMode = 2;
  # system.defaults.NSGlobalDomain."com.apple.keyboard.fnState" = true;
  # system.defaults.NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
  # system.defaults.NSGlobalDomain."com.apple.swipescrolldirection" = false;
  # system.defaults.WindowManager.EnableStandardClickToShowDesktop = true;
  # system.defaults.WindowManager.GloballyEnabled = true;
  # system.defaults.controlcenter.BatteryShowPercentage = true;
  # system.defaults.dock.appswitcher-all-displays = true;
  # system.defaults.dock.autohide = true;
  # system.defaults.finder.ShowPathbar = true;
  # system.defaults.finder.ShowStatusBar = true;
  # system.defaults.magicmouse.MouseButtonMode = "TwoButton";
  # system.defaults.menuExtraClock.Show24Hour = true;
  # system.defaults.menuExtraClock.ShowDate = 0; # or 1
  # system.defaults.screencapture.include-date = true;
  # system.defaults.screencapture.location = "/TODO";
  # system.defaults.screensaver.askForPassword = true;
  # system.defaults.trackpad.Dragging = true;
  # system.defaults.trackpad.TrackpadRightClick = true;
  # system.defaults.trackpad.TrackpadThreeFingerDrag = true;
  # system.keyboard.enableKeyMapping = true;
  # system.keyboard.swapLeftCtrlAndFn = true;

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
