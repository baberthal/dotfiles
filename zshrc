export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="morgan"

plugins=(
  git
  gulp
  colored-man-pages
  berkshelf
  bundler
  brew
  bower
  chef
  compleat
  knife
  osx
  rails
  rake-fast
  ruby
  rvm
  pip
  virtualenv
  tmux
  zeus
)

if [[ -f "$ZEXTRA_DIR/completions.zsh" ]]; then
  source "$ZEXTRA_DIR/completions.zsh"
fi
setopt autonamedirs
unset zle_bracketed_paste

export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'
bindkey -v

# export MANPATH="/usr/local/man:$MANPATH"
export PATH=$HOME/bin:$PATH
source $ZSH/oh-my-zsh.sh
source ~/bin/tmuxinator.zsh
source $ZEXTRA_DIR/aliases.zsh
source $ZEXTRA_DIR/directories.zsh
export RANGER_LOAD_DEFAULT_RC=false
source $ZEXTRA_DIR/zsh-autoenv/autoenv.zsh

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export KEYTIMEOUT=1
export LESS='-F -g -i -M -R -S -w -X -z-4'

# Set the Less input preprocessor.
# Try both `lesspipe` and `lesspipe.sh` as either might exist on a system.
if (( $#commands[(i)lesspipe(|.sh)] )); then
  export LESSOPEN="| /usr/bin/env $commands[(i)lesspipe(|.sh)] %s 2>&-"
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
export PATH="$PATH:$HOME/.rvm/bin"
compinit -u

# added by travis gem
[ -f /Users/morgan/.travis/travis.sh ] && source /Users/morgan/.travis/travis.sh
