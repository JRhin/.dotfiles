{ pkgs, ...}:

{
  programs.helix = {
    enable = true;

    # Language servers, visible only to helix (not to the whole system)
    extraPackages = with pkgs; [
      nil                                  # Nix
      python3Packages.python-lsp-server    # Python (pylsp)
    ];

    settings = {
      # theme = "catppuccin_mocha";

      editor = {
        auto-format = true;
        auto-save = true;
        bufferline = "multiple";
        completion-trigger-len = 1;
        cursorline = true;
        idle-timeout = 0;
        line-number = "relative";
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
