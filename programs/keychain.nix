{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs = {
    keychain = {
      enable = true;
      extraFlags = [
        "--quick"
        "--quiet"
      ];
      # FIXME Phase1 keys should contain an array of strings: [ "id_rsa" ]
      keys = import ./../keys.nix;
    };
  };
}
