{
  flake.modules.nixos.bluetooth = {
    hardware.bluetooth = {
      enable = true;

      settings.General = {
        Experimental = true;
      };
    };
  };
}
