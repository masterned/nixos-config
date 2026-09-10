{
  flake.modules = {
    nixos.bluetooth = {
      hardware.bluetooth = {
        enable = true;

        settings.General = {
          Experimental = true;
        };
      };
    };

    homeManager.bluetooth =
      { config, pkgs, ... }:
      let
        notify = pkgs.writers.writeNu "bluetooth-notify" /* nu */ ''
          def main [] {
            ${pkgs.glib}/bin/gdbus monitor --system --dest org.bluez
              | lines
              | where {|line| ($line | str contains "org.bluez.Device1" ) and ($line | str contains "'Connected':")}
              | each {|line|
                  { state: (if ($line | str contains "'Connected': <true>") {"Connected"} else {"Disconnected"}),
                    path: ($line | split row ':' | first),
                  }
                }
              | insert name {|dev|
                  ${pkgs.systemd}/bin/busctl --system --json=short get-property org.bluez $dev.path org.bluez.Device1 Alias
                    | complete
                    | if $in.exit_code == 0 { $in.stdout | from json | get data } else { null }
                }
              | compact name
              | each {|dev| (${pkgs.libnotify}/bin/notify-send -a Bluetooth $dev.name $dev.state)}
              | ignore
          }
        '';
      in
      {
        systemd.user.services.bluetooth-notify = {
          Unit = {
            Description = "Desktop notifications for Bluetooth connections";
            PartOf = [ config.wayland.systemd.target ];
            After = [ config.wayland.systemd.target ];
          };

          Service = {
            ExecStart = "${notify}";
            Restart = "always";
            RestartSec = 5;
          };

          Install.WantedBy = [ config.wayland.systemd.target ];
        };
      };
  };
}
