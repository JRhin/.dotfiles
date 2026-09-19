{ inputs, ... }:

{
  imports = [ inputs.zen-browser.homeModules.beta ];

  programs.zen-browser = {
    enable = true;

    profiles.jrhin = {
      extensions.packages = import ../extensions.nix { inherit inputs; };
    };
  };
}
