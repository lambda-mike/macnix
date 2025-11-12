#! /usr/bin/env bash
# flake
nix run nixpkgs#perl -- -i -wne 's/^(\s*)loginwindowText = builtins\.abort.*$/${1}loginwindowText = "login-mock";/; print' flake.nix
nix run nixpkgs#perl -- -i -wne 's/^(\s*)hostname = builtins\.abort.*$/${1}hostname = "ci-host";/; print' flake.nix
nix run nixpkgs#perl -- -i -wne 's/^(\s*)user = builtins\.abort.*$/${1}user = "test";/; print' flake.nix
nix run nixpkgs#perl -- -i -wne 's/^(\s*)windowManager = builtins\.abort.*$/${1}windowManager = "leftwm";/; print' flake.nix

echo '{ ... }: {  fileSystems = { "/".device = "/dev/fake1"; "/nix".device = "/dev/fake1"; "/home".device = "/dev/fake1"; "/data".device = "/dev/fake1"; "/snapshots".device = "/dev/fake1"; "/swap".device = "/dev/fake1"; }; }' > hardware-configuration.nix
git add hardware-configuration.nix

echo '[]' > keys.nix
git add keys.nix

# configuration
nix run nixpkgs#perl -- -i -wne 's/^(\s*)# CIFIXME_TEST.*$/${1}users.users.test.isNormalUser = true;/; print' sage_configuration.nix

