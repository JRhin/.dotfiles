{ config, pkgs, ... }:

let
  # Same mapping Stylix's own Noctalia target uses for the shell
  colors = config.lib.stylix.colors.withHashtag;
in
{
  services.displayManager.noctalia-greeter = {
    enable = true;

    cursorTheme = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
    };

    settings = {
      user.default = "jrhin";   # optional: jump straight to the password step

      appearance = {
        scheme = "Synced";
        theme_mode = "dark";
        font_family = config.stylix.fonts.sansSerif.name;

        palette = {
          primary = colors.base0D;
          on_primary = colors.base00;
          secondary = colors.base0E;
          on_secondary = colors.base00;
          tertiary = colors.base0C;
          on_tertiary = colors.base00;
          error = colors.base08;
          on_error = colors.base00;
          surface = colors.base00;
          on_surface = colors.base05;
          surface_variant = colors.base01;
          on_surface_variant = colors.base04;
          outline = colors.base03;
          shadow = colors.base00;
          hover = colors.base0C;
          on_hover = colors.base00;
        };

        wallpaper = {
          path = "${config.stylix.image}";
          fill_mode = "crop";
        };
      };

      keyboard.layout = "it";
      cursor.size = 24;
    };
  };

    # Unlock gnome-keyring at login (greetd does not do it by itself, GDM did)
  security.pam.services.greetd.enableGnomeKeyring = true;
}
