{pkgs, inputs, ...}:
{
  wayland.windowManager.hyprland = {
    enable = true;

    # The hyprland package to use
    package = inputs.hyprland.packages."${pkgs.system}".hyprland;

    # Whether to enable XWayland
    xwayland.enable = true;

    # Optional
    # Whether to enable hyprland-session.target on hyprland startup
    systemd.enable = true;

    plugins = [
    ];

    settings = {
    };
  };
}
