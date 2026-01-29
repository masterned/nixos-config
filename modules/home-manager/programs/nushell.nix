{ ... }:
{
  programs.nushell = {
    enable = true;
    environmentVariables = {
      NH_FLAKE = "/home/spencer/Workspaces/nixos";
      EDITOR = "hx";
      VISUAL = "hx";
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "$env.HOME/.steam/root/compatibilitytools.d";
      SSH_AUTH_SOCK = "/run/user/1000/ssh-agent";
    };
    extraConfig = # nu
      ''
        $env.config = {
          show_banner: false
          edit_mode: vi
        }
      '';
  };
}
