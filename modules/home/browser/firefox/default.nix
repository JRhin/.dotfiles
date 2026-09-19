{inputs, ...}:

{
  programs.firefox = {
    enable = true;

    profiles.jrhin = {
      extensions.packages = import ../extensions.nix { inherit inputs; };
    };
  };
}
