opts@{ rev, dirtyRev, loginwindowText }:
{ pkgs, ... }: {
  environment.systemPackages = [
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

  system.defaults = {
    # dock.autohide = true;
    # dock.mru-spaces = true;
    # finder.AppleShowAllExtensions = true;
    finder.FXPreferredViewStyle = "clmv";
    fonts.packages = with pkgs; [
      jetbrains-mono
      nerd-fonts.nerd-fonts-_3270
      nerd-fonts.nerd-fonts-agave
      nerd-fonts.nerd-fonts-hack
      nerd-fonts.nerd-fonts-cousine
      nerd-fonts.nerd-fonts-fira-mono
      nerd-fonts.nerd-fonts-hurmit
      nerd-fonts.nerd-fonts-iosevka
      nerd-fonts.nerd-fonts-mononoki
      nerd-fonts.nerd-fonts-roboto-mono
      nerd-fonts.nerd-fonts-terminess-ttf
      nerd-fonts.nerd-fonts-ubuntu-mono
    ];
    loginwindow.LoginwindowText = loginwindowText;
    programs.bash.enable = true;
    programs.direnv.enable = true;
    programs.fish.enable = true;
    programs.vim.enable = true;
    programs.vim.enableSensible = true;
    # programs.zsh.enable = true;  # default shell on catalina
    screencapture.location = "~/Pictures/screenshots";
    # services.prometheus.exporters.node.enable
    # ".GlobalPreferences"."com.apple.sound.beep.sound" = /System/Library/Sounds/;
    # ActivityMonitor.IconType = 5;
    # NSGlobalDomain.AppleInterfaceStyle = "Dark";
    # NSGlobalDomain.InitialKeyRepeat = 200;
    # NSGlobalDomain.KeyRepeat = 100;
    # NSGlobalDomain.NSScrollAnimationEnabled = true;
    # NSGlobalDomain.NSTableViewDefaultSizeMode = 2;
    # NSGlobalDomain."com.apple.keyboard.fnState" = true;
    # NSGlobalDomain."com.apple.mouse.tapBehavior" = 1;
    # NSGlobalDomain."com.apple.swipescrolldirection" = false;
    # WindowManager.EnableStandardClickToShowDesktop = true;
    # WindowManager.GloballyEnabled = true;
    # controlcenter.BatteryShowPercentage = true;
    # dock.appswitcher-all-displays = true;
    # dock.autohide = true;
    # finder.ShowPathbar = true;
    # finder.ShowStatusBar = true;
    # magicmouse.MouseButtonMode = "TwoButton";
    # menuExtraClock.Show24Hour = true;
    # menuExtraClock.ShowDate = 0; # or 1
    # screencapture.include-date = true;
    # screencapture.location = "/TODO";
    # screensaver.askForPassword = true;
    # screensaver.askForPasswordDelay = 7;
    # trackpad.Dragging = true;
    # trackpad.TrackpadRightClick = true;
    # trackpad.TrackpadThreeFingerDrag = true;
  };
  # system.keyboard.enableKeyMapping = true;
  # system.keyboard.swapLeftCtrlAndFn = true;

  # enable sudo auth via touch id
  security.pam.services.sudo_local.touchIdAuth = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = opts.rev or opts.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
