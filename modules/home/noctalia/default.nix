{ inputs, ... }:

{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia = {
    enable = true;

    # Run the shell as a systemd user service
    systemd.enable = true;

  };
}
