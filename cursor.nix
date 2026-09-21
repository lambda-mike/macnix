{ pkgs, ... }:

{
  home = {
    pointerCursor = {
      enable = true;
      package = pkgs.vanilla-dmz;
      name = "Vanilla-DMZ-AA";
      size = 24;
      x11.enable = true;
    };
  };
}
