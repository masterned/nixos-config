{ ... }:
{
  programs.bottom = {
    enable = true;
    settings = {
      flags = {
        battery = true;
        disable_advanced_kill = true;
        temperature_type = "c";
      };
      styles = {
        theme = "nord";
      };
    };
  };
}
