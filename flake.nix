{
  description = "MacNix configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      home-manager,
      nixpkgs,
      nix-darwin,
      nixos-hardware,
      self,
      ...
    }:
    {
      darwinConfigurations =
        let
          darwin = {
            helixTheme = "catppuccin_mocha";
            loginwindowText = builtins.abort "TODO LoginwindowText";
            hostname = builtins.abort "TODO set hostname";
            user = builtins.abort "TODO set username";
            rev = self.rev or "ci";
            dirtyRev = self.rev or "ci";
          };
        in
        {
          ${darwin.hostname} = nix-darwin.lib.darwinSystem {
            system = "aarch64-darwin";
            modules = [
              (import ./configuration.nix {
                inherit (darwin) loginwindowText user;
                rev = darwin.rev;
                dirtyRev = darwin.dirtyRev;
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
            hostname = builtins.abort "TODO set hostname";
            user = builtins.abort "TODO set username";
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
      nixosConfigurations = let
        sage = {
          helixTheme = "catppuccin_mocha";
          hostname = builtins.abort "TODO set hostname";
          user = builtins.abort "TODO set username";
          theme = (import ./themes.nix).green;
          windowManager = builtins.abort "TODO set windowManager";
          stateVersion = builtins.abort "TODO set stateVersion to installed nixos version";
        };
      in {
        ${sage.hostname} = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            nixos-hardware.nixosModules.framework-12-13th-gen-intel
            (import ./sage_configuration.nix { inherit (sage) hostname stateVersion; })
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${sage.user} = (import ./sage_home.nix { inherit (sage) helixTheme user theme windowManager stateVersion; });
              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
            }
          ];
        };
      };
    };
}
