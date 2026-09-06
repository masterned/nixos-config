{
  flake.modules.nixos.boot = { pkgs, ... }: {
    boot = {
      initrd.systemd.enable = true;

      kernelPackages = pkgs.linuxPackages_latest;

      loader = {
        systemd-boot.enable = true;
        efi.canTouchEfiVariables = true;
      };

      plymouth.enable = true;
    };
  };
}
