{config, pkgs, ...}:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;

    initExtra = ''
    declare -a PROMPTS
    PROMPTS=(
      "∮"
      ""
      ""
      ""
      ""
      ""
      ""
    )
    RANDOM=$$$(date +%s)
    ignition=''${PROMPTS[$RANDOM % ''${#RANDOM[*]}+1]}
    PROMPT="%F{blue}%1~%f %F{cyan}$ignition%f "

    ## Git Settings
    autoload -Uz vcs_info
    precmd_vcs_info() { vcs_info }
    precmd_functions+=( precmd_vcs_info )
    setopt prompt_subst
    RPROMPT=\$vcs_info_msg_0_
    zstyle ':vcs_info:git:*' formats '%F{yellow}(%b)%r%f'
    zstyle ':vcs_info:*' enable git

    eval "$(zoxide init --cmd cd zsh)"
    eval "$(zellij setup --generate-auto-start zsh)"
    '';

    shellAliases = {
      ".." = "cd ..";
      "..." = "cd ../..";
      cl = "clear";
      dot = "cd ~/.dotfiles";
      ll = "ls -l";
      nd = "nix develop -c $SHELL";
      update = "sudo nixos-rebuild --flake";
    };

    history.size = 10000;
    history.path = "${config.xdg.dataHome}/zsh/history";
  };
}
