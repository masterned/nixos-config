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
          def device-name [path: string] {
            let alias = (${pkgs.systemd}/bin/busctl --system --json=short get-property org.bluez $path org.bluez.Device1 Alias
              | complete
            )
            
            if $alias.exit_code == 0 {
              $alias.stdout | from json | get data
            } else {
              $path | split row '/dev_' | last | str replace --all '_' ':'
            }
          }

          def main [] {
            ${pkgs.glib}/bin/gdbus monitor --system --dest org.bluez
              | lines
              | where {|line| ($line | str contains "PropertiesChanged ('org.bluez.Device1'") and ($line | str contains "'Connected': <")}
              | each {|line|
                let path = ($line | split row ':' | first)
                  { name: (device-name $path)
                    state: (if ($line | str contains "'Connected': <true>") {"Connected"} else {"Disconnected"}),
                  }
                }
              | each {|dev|
                  ${pkgs.libnotify}/bin/notify-send -a Bluetooth $dev.name $dev.state
                    | complete
                    | ignore
                }
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
