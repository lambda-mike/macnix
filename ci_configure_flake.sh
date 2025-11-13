#!/usr/bin/env bash
set -exuo pipefail

perl -i -wpl -e '
  s/^(\s*)loginwindowText = builtins\.abort.*$/${1}loginwindowText = "login-mock";/;
  s/^(\s*)hostname = builtins\.abort.*$/${1}hostname = "ci-host";/;
  s/^(\s*)user = builtins\.abort.*$/${1}user = "test";/;
  s/^(\s*)windowManager = builtins\.abort.*$/${1}windowManager = "leftwm";/;
' flake.nix

perl -i -wpl -e 's/^(\s*)# CIFIXME_TEST.*$/${1}users.users.test.isNormalUser = true;/;' sage_configuration.nix

echo '{ ... }: {  fileSystems = { "/".device = "/dev/fake1"; "/nix".device = "/dev/fake1"; "/home".device = "/dev/fake1"; "/data".device = "/dev/fake1"; "/snapshots".device = "/dev/fake1"; "/swap".device = "/dev/fake1"; }; }' > hardware-configuration.nix

git add hardware-configuration.nix

echo '[]' > keys.nix
git add keys.nix

echo 'Done';
