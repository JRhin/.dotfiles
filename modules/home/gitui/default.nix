{...}:

{
  programs.gitui = {
    enable = true;
    theme = ''
              (
                selected_tab: Some(Reset),
                command_fg: Some(Rgb(202, 211, 245)),
                selection_bg: Some(Rgb(91, 96, 120)),
                selection_fg: Some(Rgb(202, 211, 245)),
                cmdbar_bg: Some(Rgb(30, 32, 48)),
                cmdbar_extra_lines_bg: Some(Rgb(30, 32, 48)),
                disabled_fg: Some(Rgb(128, 135, 162)),
                diff_line_add: Some(Rgb(166, 218, 149)),
                diff_line_delete: Some(Rgb(237, 135, 150)),
                diff_file_added: Some(Rgb(238, 212, 159)),
                diff_file_removed: Some(Rgb(238, 153, 160)),
                diff_file_moved: Some(Rgb(198, 160, 246)),
                diff_file_modified: Some(Rgb(245, 169, 127)),
                commit_hash: Some(Rgb(183, 189, 248)),
                commit_time: Some(Rgb(184, 192, 224)),
                commit_author: Some(Rgb(125, 196, 228)),
                danger_fg: Some(Rgb(237, 135, 150)),
                push_gauge_bg: Some(Rgb(138, 173, 244)),
                push_gauge_fg: Some(Rgb(36, 39, 58)),
                tag_fg: Some(Rgb(244, 219, 214)),
                branch_fg: Some(Rgb(139, 213, 202))
            )'';
  };
}
