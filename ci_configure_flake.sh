#!/usr/bin/env bash
nix run nixpkgs#perl -- -i -wne 's/^(\s*)loginwindowText = builtins\.abort.*$/${1}loginwindowText = "login-mock"/; print' flake.nix
nix run nixpkgs#perl -- -i -wne 's/^(\s*)hostname = builtins\.abort.*$/${1}hostname = "ci-host"/; print' flake.nix
nix run nixpkgs#perl -- -i -wne 's/^(\s*)user = builtins\.abort.*$/${1}user = "test"/; print' flake.nix
