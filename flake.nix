{
  description = "Config flake for cygnus";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ashell.url = "github:MalpenZibo/ashell";

    helix = {
      url = "github:helix-editor/helix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";

    stylix.url = "github:danth/stylix";

    wezterm = {
      url = "github:wez/wezterm/main?dir=nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
    inherit (self) outputs;
    system = "x86_64-linux";
  in
  {
    formatter = nixpkgs.legacyPackages.${system}.nixfmt-rfc-style;
    
    overlays = import ./overlays { inherit inputs; };

    homeManagerModules = import ./modules/home-manager;

    nixosConfigurations = {
      cygnus = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs;
        };
        modules = [
          {
            nix.settings = {
              substituters = [
                "https://hyprland.cachix.org"
                "https://wezterm.cachix.org"
                "https://helix.cachix.org"
              ];
              trusted-public-keys = [
                "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
                "wezterm.cachix.org-1:kAbhjYUC9qvblTE+s7S+kl5XM1zVa4skO+E/1IDWdH0="
                "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
              ];
            };
          }
          inputs.nixos-hardware.nixosModules.framework-13-7040-amd
          ./configuration.nix
        ];
      };
    };
  };
}
