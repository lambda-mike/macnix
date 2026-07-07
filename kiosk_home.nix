{ user, stateVersion }:
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
    ./services/redshift.nix
  ];

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    packages = (with pkgs; [
      brave
      fd
      font-awesome
      gimp
      krita
      libreoffice
      python312
      tuxpaint
      tuxtype
      qrcode
    ]);
    sessionVariables = {
      # Other env vars here cause issues during fish shell startup
    };
    stateVersion = stateVersion;
  };

  fonts.fontconfig.enable = true;

  programs = import ./core/kiosk_programs.nix { inherit config pkgs; } // {
    # Overwrite programs here
  };
}

