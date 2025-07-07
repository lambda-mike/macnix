{ ... }:
{
  xdg = {
    enable = true;
    configFile.".doom.d" = {
      source = ./.doom.d;
      recursive = true;
    };
  };
}
