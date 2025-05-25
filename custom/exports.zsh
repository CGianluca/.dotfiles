# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS=" --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort' --color header:italic --header 'Press CTRL-Y to copy command into clipboard'"


# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS=" --walker-skip .git,node_modules,target --preview 'bat -n --color=always {}' --bind 'ctrl-/:change-preview-window(down|hidden|)'"
