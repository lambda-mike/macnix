{
  description = "MacNix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs =
    {
      home-manager,
      nixpkgs,
      nix-darwin,
      self,
      ...
    }:
    {
      darwinConfigurations =
        let
          darwin = {
            helixTheme = "catppuccin_mocha";
            loginwindowText = builtins.abort "TODO LoginwindowText";
            hostname = builtins.abort "TODO set correct 'hostname'";
            user = builtins.abort "TODO: set proper username";
          };
        in
        {
          ${darwin.hostname} = nix-darwin.lib.darwinSystem {
            system = "aarch64-darwin";
            modules = [
              (import ./configuration.nix {
                inherit (self) rev dirtyRev;
                inherit (darwin) loginwindowText user;
              })
              home-manager.darwinModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.${darwin.user} = (import ./home.nix { inherit (darwin) helixTheme user; });

                # Optionally, use home-manager.extraSpecialArgs to pass
                # arguments to home.nix
              }
            ];
          };
        };
      homeConfigurations =
        let
          wsl = {
            helixTheme = "catppuccin_mocha";
            hostname = builtins.abort "TODO set correct 'hostname'";
            user = builtins.abort "TODO: set proper username";
          };
        in
        {
          ${wsl.user} = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages."x86_64-linux";

            # Specify your home configuration modules here, for example,
            # the path to your home.nix.
            modules = [ (import ./home_wsl.nix { inherit (wsl) helixTheme user; }) ];

            # Optionally use extraSpecialArgs
            # to pass through arguments to home.nix
          };
        };
    };
}
