# `pure` prompt default overrides

# appearance
set --global pure_enable_single_line_prompt true
set --global pure_enable_container_detection false
set --global pure_check_for_new_release false
set --global pure_color_git_branch brcyan

# path: shorten every component but the last to 1 char (~/a/s/repo)
set --global pure_shorten_prompt_current_directory_length 1
set --global pure_truncate_prompt_current_directory_keeps 20

# QoL
set --global pure_show_exit_status true

# git: numbered ahead/behind arrows, visible dirty marker
set --global async_prompt_functions _pure_prompt_git
set --global pure_show_numbered_git_indicator true
set --global pure_color_git_dirty yellow
set --global pure_symbol_git_dirty ' *'
