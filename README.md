# macnix

Set up Nix on MacOS using nix-darwin and home-manager with flakes:

- [home-manager instructions](https://nix-community.github.io/home-manager/index.xhtml#sec-flakes-nix-darwin-module)
- [nix-darwin configuration options](https://nix-darwin.github.io/nix-darwin/manual/index.html)
- [Nix cheatsheet](https://nixcademy.com/downloads/cheatsheet.pdf)

## Installation

[Source](https://nixcademy.com/posts/nix-on-macos/)

1. Install Nix with determinate systems installer:

`curl -fsSL https://install.determinate.systems/nix | sh -s -- install --determinate`

2. Test by running: `nix run "nixpkgs#hello"`

3. Set up Mac by running: `darwin-rebuild switch --flake <flake-uri>.`

`<flake-uri>` could be: `~/macnix.#myhostname`

4. To update flake inputs run: `nix flake update` or more granularly: `nix flake lock --update-input <input>`
