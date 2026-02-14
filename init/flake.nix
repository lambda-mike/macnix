{
  description = "MacNix initial test configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      home-manager,
      nixpkgs,
      nixos-hardware,
      self,
      ...
    }:
    {
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
            (import ./configuration.nix { inherit (sage) hostname stateVersion; })
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${sage.user} = (import ./home.nix { inherit (sage) helixTheme user theme windowManager stateVersion; });
              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
            }
          ];
        };
      };
    };
}
