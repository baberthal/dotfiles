PROFILE_STARTUP=false
if [[ "$PROFILE_STARTUP" == true ]]; then
  PS4=$'%D{%M%S%.} %N:%i> '
  exec 3>&2 2>$HOME/tmp/startlog.$$
  setopt xtrace prompt_subst
fi

export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="morgan"

plugins=(
  colored-man-pages
  berkshelf
  bundler
  brew
  bower
  chef
  compleat
  git
  gulp
  knife
  npm
  osx
  rails
  rake-fast
  ruby
  rvm
  pip
  pow
  tmux
  virtualenv
  virtualenvwrapper
  zeus
)

[[ -f "$ZEXTRA_DIR/completions.zsh" ]] && source "$ZEXTRA_DIR/completions.zsh"
setopt autonamedirs
unset zle_bracketed_paste

# export MANPATH="/usr/local/man:$MANPATH"
source $ZSH/oh-my-zsh.sh
[[ -f "${HOME}/bin/tmuxinator.zsh" ]] && source "${HOME}/bin/tmuxinator.zsh"
source $ZEXTRA_DIR/aliases.zsh
source $ZEXTRA_DIR/directories.zsh
export RANGER_LOAD_DEFAULT_RC=false
[[ -f "${ZEXTRA_DIR}/zsh-autoenv/autoenv.zsh" ]] && source "${ZEXTRA_DIR}/zsh-autoenv/autoenv.zsh"

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

[ -f /Users/morgan/.travis/travis.sh ] && source /Users/morgan/.travis/travis.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
# export SDKMAN_DIR="/Users/morgan/.sdkman"
# [[ -s "/Users/morgan/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/morgan/.sdkman/bin/sdkman-init.sh"

# [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
# export PATH="$PATH:$HOME/.rvm/bin"
compinit -u
source "/usr/local/bin/aws_zsh_completer.sh"

export WORKON_HOME="${HOME}/projects/python/.virtualenv"
export PROJECT_HOME="${HOME}/projects/python"

if [[ "$PROFILE_STARTUP" == true ]]; then
  unsetopt xtrace
  exec 2>&3 3>&-
fi
