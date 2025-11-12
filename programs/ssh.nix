{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs = {
    ssh = {
      enable = true;
      enableDefaultConfig = false;
      matchBlocks."*" = {
          forwardAgent = false;
          addKeysToAgent = "yes";
          compression = true;
          userKnownHostsFile = "~/.ssh/known_hosts";
        };
    };
  };
}
