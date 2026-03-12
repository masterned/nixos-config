{ outputs, ... }:

{
  imports = [ outputs.hosts.cygnus ];

  system.stateVersion = "23.05"; # No touchy!
}
