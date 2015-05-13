export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="morgan"

DISABLE_AUTO_UPDATE="true"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"

plugins=(git brew brew-cask bower bundler compleat git gitignore github lol osx rails rake ruby rvm tmux tmuxinator vundle)

export EDITOR="vim"
bindkey -v

export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$PATH:$HOME/Library/Android/sdk/platform-tools

# export MANPATH="/usr/local/man:$MANPATH"

export POWERLINE_CONFIG_COMMAND=/Users/morgan/.vim/bundle/powerline/scripts/powerline-config
export HOMEBREW_GITHUB_API_TOKEN=22a666338b8aa4ce66c3ceb0f2151c7233f8acd4

source $ZSH/oh-my-zsh.sh
source ~/bin/tmuxinator.zsh
source ~/.nvm/nvm.sh

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export KEYTIMEOUT=1
pbn=~/projects/puck_by_numbers

# ssh wrapper that renames current tmux window to the hostname of the remote host
#ssh() {
# tmux rename-window "$*"
# command ssh "$@"
# exit
#}
ssh() {
# Do nothing if we are not inside tmux or ssh is called without arguments
  if [[ $# == 0 || -z $TMUX ]]; then
    command ssh $@
    return
  fi
  # The hostname is the last parameter (i.e. ${(P)#})
  local remote=${${(P)#}%.*}
  local old_name="$(tmux display-message -p '#W')"
  local renamed=0
  # Save the current name
  if [[ $remote != -* ]]; then
    renamed=1
    tmux rename-window $remote
  fi
  command ssh $@
  if [[ $renamed == 1 ]]; then
    tmux rename-window "$old_name"
  fi
}


pygless()
{
  LESSOPEN="| pygmentize -f terminal256 -O style=solarized -g %s" less -R "$@";
}



alias zshrc="vim ~/.zshrc"
alias vimrc="vim ~/.vimrc"
alias tmuxconf="vim ~/.tmux.conf"
export LESSOPEN="| source-highlight -f esc -i %s -o STDOUT"
export LESS=" -R "
alias nest="nest.py --user j.morgan.lieberthal@gmail.com --password kbner7xL"
alias gclone="git clone --recursive"
export R_HOME=/usr/local/Cellar/r/3.2.0/R.framework/Resources


### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}


