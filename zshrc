export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="morgan"
# source $ZEXTRA_DIR/env.zsh

plugins=(git gulp brew bundler bower compleat gem lol osx rails rake-fast ruby rvm tmux tmuxinator zeus)
setopt autonamedirs
unset zle_bracketed_paste

export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'
bindkey -v

# export MANPATH="/usr/local/man:$MANPATH"
export POWERLINE_CONFIG_COMMAND=/Users/morgan/.vim/bundle/powerline/scripts/powerline-config
export HOMEBREW_GITHUB_API_TOKEN=22a666338b8aa4ce66c3ceb0f2151c7233f8acd4
export PATH=$HOME/bin:$PATH
source $ZSH/oh-my-zsh.sh
source ~/bin/tmuxinator.zsh
source $ZEXTRA_DIR/aliases.zsh
source $ZEXTRA_DIR/directories.zsh
source $ZSH_CUSTOM/functions.zsh

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
