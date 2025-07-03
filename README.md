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

3. Set up Mac by running: `darwin-rebuild switch --flake <flake-uri>`

`<flake-uri>` could be: `~/macnix.#myhostname`

In order to run nix-darwin without installing it first: `nix run nix-darwin -- switch --flake <flake-uri>`

Once you need `sudo` when installing for the first time, the simplest probably is:

```bash
nix shell nix-darwin
sudo darwin-rebuild switch --flake <flake-uri>
```

## Update

### nix-darwin

1. `nix flake update`

In Git repo: `nix flake update --commit-lock-file` can automatically commit the lock file changes.

2. `darwin-rebuild switch --flake <flake-uri>`

`<flake-uri>` could be: `~/macnix.#myhostname` or simply `.` when running from flake root folder.

To update flake inputs more granularly: `nix flake lock --update-input <input>`

### nix

Use determinate nix daemon to ugrade nix:

`sudo determinate-nixd upgrade`
