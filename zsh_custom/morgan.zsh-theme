precmd() {
    local version="\$(~/.rvm/bin/rvm-prompt v)"
    [[ $(~/.rvm/bin/rvm-prompt i) = 'ruby' ]] && local interp='' || local interp=$(~/.rvm/bin/rvm-prompt u)
    [[ $(~/.rvm/bin/rvm-prompt g) = '' ]] && local gemset='(default)' || local gemset="${$(~/.rvm/bin/rvm-prompt g)#'@'}"
    RPROMPT="%{$fg[yellow]%}$interp%{$reset_color%} %{$fg[red]%}$version%{$reset_color%} @ %{$fg[blue]%}$gemset%{$reset_color%}"
}

zle-keymap-select() {
    RPROMPT=""
    [[ $KEYMAP = vicmd ]] && RPROMPT="%{$fg[blue]%}(CMD)"
    () { return $__prompt_status }
    zle reset-prompt
}

zle-line-init() {
    typeset -g __prompt_status="$?"
}
zle -N zle-keymap-select
zle -N zle-line-init

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

function box_name {
    [ -f ~/.box-name ] && cat ~/.box-name || hostname -s
}

ONE_LINER='%{$fg[magenta]%}%n%{$reset_color%} at %{$fg[yellow]%}$(box_name)%{$reset_color%} in %{$fg[green]%}%~%{$reset_color%}$(git_prompt_info) %{$reset_color%}%(?,,%{${fg_bold[blue]}%}[%?]%{$reset_color%} )'
TWO_LINER="$ONE_LINER"$'\n'"$ "

if [[ $COLUMNS -lt 80 ]]; then
    PROMPT=$TWO_LINER
else
    PROMPT="$ONE_LINER$ "
fi

RPROMPT='$(rvm_info)'

ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[magenta]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[green]%}!"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[green]%}?"
ZSH_THEME_GIT_PROMPT_CLEAN=""

local return_status="%{$fg[red]%}%(?..⤬)%{$reset_color%}"
RPROMPT='${return_status}%{$reset_color%}'

#  vim: set ts=8 sw=4 tw=0 ft=zsh et :
