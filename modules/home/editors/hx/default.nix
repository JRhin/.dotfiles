{...}:

{
  programs.helix = {
    enable = true;

    settings = {
      theme = "catppuccin_mocha";

      editor = {
        line-number = "relative";
        cursorline = true;
        idle-timeout = 0;
        completion-trigger-len = 1;
        bufferline = "multiple";
        auto-save = true;
        soft-wrap.enable = true;

        statusline = {
          left = [
            "mode"
            "spinner"
            "version-control"
            "file-name"
            "file-modification-indicator"
            "file-encoding"
            "file-line-ending"
            "file-type"
          ];

          right = [
            "workspace-diagnostics"
            "selections"
            "position"
          ];
        };

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        indent-guides = {
          render = true;
          character = "|";
        };

        lsp = {
          display-inlay-hints = true;
          display-messages = true;
        };
      };
    };

    languages = {
      language = [
        {
          name = "python";
        }
        {
          name = "nix";
        }
      ];
    };
  };
}
