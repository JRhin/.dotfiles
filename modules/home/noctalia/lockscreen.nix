{ lib }:

let
  # connector name and LOGICAL size, from `niri msg outputs`
  screens = [
    { name = "eDP-1"; w = 1536.0; h = 864.0; }
    { name = "HDMI-A-1"; w = 3440.0; h = 1440.0; }
  ];

  # All lock screen widgets of one output, positioned as fractions of its size.
  # Sizes are relative to the screen height so they look alike on both monitors.
  lockWidgets = s:
    let
      u = s.h;
      id = n: "${n}-${s.name}";
      at = fx: fy: { output = s.name; cx = s.w * fx; cy = s.h * fy; rotation = 0.0; };
    in
    {
      ${id "locked"} = at 0.5 0.20 // {
        type = "label";
        box_width = 0.0;
        box_height = 0.0;
        settings = { title = "L O C K E D"; description = ""; background = false; };
      };

      ${id "clock"} = at 0.5 0.34 // {
        type = "clock";
        box_width = 0.44 * u;
        box_height = 0.17 * u;
        settings = { format = "{:%H:%M}"; center_text = true; };
      };

      ${id "date"} = at 0.5 0.44 // {
        type = "clock";
        box_width = 0.24 * u;
        box_height = 0.045 * u;
        settings = { format = "{:%a, %b %d}"; center_text = true; background = false; };
      };

      ${id "volume"} = (
        {
          output = s.name;
          cx = s.w * 0.5 - 0.115 * u;
          cy = s.h * 0.53;
          rotation = 0.0;
        }
      ) // {
        type = "volume";
        box_width = 0.20 * u;
        box_height = 0.11 * u;
        settings = { device = "output"; show_device = true; };
      };

      ${id "sysmon"} = {
        output = s.name;
        cx = s.w * 0.5 + 0.115 * u;
        cy = s.h * 0.53;
        rotation = 0.0;
        type = "sysmon";
        box_width = 0.20 * u;
        box_height = 0.11 * u;
        settings = {
          display = "graph";
          stat = "cpu_usage";
          stat2 = "cpu_temp";
        };
      };

      ${id "spectrum"} = at 0.5 0.75 // {
        type = "audio_visualizer";
        box_width = 0.85 * u;
        box_height = 0.16 * u;
        settings = {
          background = false;
          bands = 32;
          mirrored = true;
          centered = false;
          show_when_idle = false;
          color_1 = "primary";
          color_2 = "primary";
        };
      };

      # Password box with media and weather; it can be moved but not resized
      "lockscreen-login-box@${s.name}" = at 0.5 0.89 // {
        type = "login_box";
        settings = {
          layout = "regular";
          show_media = true;
          show_weather = true;
          show_session_buttons = false;   # no logout / reboot / shutdown buttons
          show_unlock_hint = false;       # no status card ("Type your password...", "Authenticating")
        };
      };
    };
in
{
  enabled = true;
  schema_version = 2;
  widget_order = lib.concatMap (s: builtins.attrNames (lockWidgets s)) screens;
  widget = lib.foldl' (acc: s: acc // lockWidgets s) { } screens;
}
