{ inputs, ... }:
{
  modifications = final: prev: {
    helix = inputs.helix.packages.${final.system}.default;

    hyprland = inputs.hyprland.packages.${final.system}.hyprland;

    wezterm = inputs.wezterm.packages.${final.system}.default;
  };

  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
