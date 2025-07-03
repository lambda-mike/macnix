{ blockedBranch }:
{ config, lib, pkgs, ... }:

# FIXME
# to overwrite ssh key in given git repo, add to its local config:
# sshCommand = ssh -i ~/.ssh/key
let prePushBlockBranchScriptText =
    builtins.replaceStrings
      [ "%BRANCH%" ]
      [ blockedBranch ]
      (builtins.readFile ../scripts/git_block_branch.sh);
in {
  programs = {
    git = {
      enable = true;
      aliases = {
        br = "branch";
        ci = "commit";
        co = "checkout";
        dc = "diff --cached";
        d = "diff";
        lg = "log --pretty='%Cred%h%Creset | %C(yellow)%d%Creset %s %Cgreen(%cr)%Creset %C(cyan)[%an]%Creset' --graph";
        so = "show --pretty='parent %Cred%p%Creset commit %Cred%h%Creset%C(yellow)%d%Creset %n%n%w(72,2,2) %s%n%n%w(72,0,0) %C(cyan)%an%Creset %Cgreen%ar%Creset'";
        st = "status";
        s = "status -s";
      };
      hooks = {
        pre-push = pkgs.writeText "git-pre-push.sh" prePushBlockBranchScriptText;
      };
      userName = "TODO";
      userEmail = "todo@todo.com";
    };
  };
}
