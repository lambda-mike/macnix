{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs = {
    ssh = {
      compression = true;
      enable = true;
    };
  };
}
