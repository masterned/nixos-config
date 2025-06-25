{ inputs, ... }:
{
  modifications = final: prev: {
    floorp = prev.floorp.override {
      extraPolicies = {
        # WindowsSSO = true;
        DisablePocket = true;
        DisableTelemetry = true;
      };
    };

    helix = inputs.helix.packages.${final.system}.default;

    hyprland = inputs.hyprland.packages.${final.system}.hyprland;

    mpv = prev.mpv.override {
      scripts = [
        final.mpvScripts.mpris
        final.mpvScripts.skipsilence
      ];
    };

    wezterm = inputs.wezterm.packages.${final.system}.default;

    zen-browser = inputs.zen-browser.packages.${final.system}.default;
  };

  stable-packages = final: _prev: {
    stable = import inputs.nixpkgs-stable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
