{
  description = "MacNix Darwin configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      home-manager,
      nix-darwin,
      self,
      ...
    }:
    {
      darwinConfigurations = let
        loginwindowText = builtins.abort "TODO LoginwindowText";
        myhostname = builtins.abort "TODO set correct 'myhostname'";
        user = builtins.abort "TODO: set proper username";
      in {
        ${myhostname} = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = [
            (./configuration.nix { inherit (self) rev dirtyRev; inherit loginwindowText; })
            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${user} = (./home.nix { inherit user; });

              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
            }
          ];
        };
      };
    };
}
