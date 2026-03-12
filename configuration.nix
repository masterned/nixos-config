{ outputs, ... }:

{
  imports = [ outputs.hostModules.cygnus ];

  system.stateVersion = "23.05"; # No touchy!
}
