{ inputs, pkgs, ... }:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  imports = [ inputs.spicetify-nix.homeManagerModules.spicetify ];

  programs.spicetify = {
    enable = true;

    # Theme and colorScheme are set by Stylix (stylix.targets.spicetify),
    # so they are intentionally not defined here: defining them would conflict.

    enabledExtensions = with spicePkgs.extensions; [
      shuffle
    ];
  };
}
