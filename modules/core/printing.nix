{
  flake.modules.nixos.printing =
    { pkgs, ... }:
    {
      hardware.sane = {
        enable = true;
        extraBackends = [ pkgs.sane-airscan ];
        disabledDefaultBackends = [ "escl" ];
      };

      services = {
        avahi = {
          enable = true;
          nssmdns4 = true;
          openFirewall = true;
        };

        printing = {
          enable = true;
          drivers = with pkgs; [
            gutenprint
            hplip
          ];
        };
      };
    };
}
