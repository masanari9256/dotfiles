autoload -U colors && colors

PROMPT='
======================================================================================

%F{magenta}%~%f $(git_prompt_info)$(git_dirty_count)
%F{15}'

git_prompt_info() {
  ref=$(git symbolic-ref HEAD 2> /dev/null) || return
  echo "%F{green}git:%F{green}(%F{yellow}${ref#refs/heads/}%F{green})"
}

git_dirty_count() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == true ]]; then
    local dirty_count=$(git status --porcelain | wc -l | tr -d ' ')
    if [[ $dirty_count -gt 0 ]]; then
      echo "±$dirty_count"
    fi
  fi
}

ZSH_THEME_GIT_PROMPT_PREFIX="%F{green}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f "
ZSH_THEME_GIT_PROMPT_DIRTY="%F{yellow}*%f"
ZSH_THEME_GIT_PROMPT_CLEAN="%F{green}%f"
