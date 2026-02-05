{ outputs, pkgs, ... }:
{
  boot = {
    initrd.systemd.enable = true;
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    plymouth.enable = true;
  };
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    material-symbols
  ];
  hardware.keyboard.zsa.enable = true;
  imports = [
    outputs.nixosModules.hypr
    # outputs.nixosModules.programs.regreet
    outputs.nixosModules.services.ly
    outputs.nixosModules.services.pipewire
  ];
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };
  };
  networking.networkmanager = {
    enable = true;
    insertNameservers = [
      "9.9.9.9" # Quad9
      "1.1.1.1" # Cloudflare
    ];
  };
  programs.ssh.startAgent = true;
  services = {
    fwupd.enable = true;
    gvfs.enable = true;
    seatd.enable = true;
  };
  time.timeZone = "America/New_York";
}
