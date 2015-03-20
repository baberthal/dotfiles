# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="morgan"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git brew brew-cask gem git-extras github knife knife_ssh lol osx pip python rails rand-quote ruby rvm tmux vundle xcode)

# User configuration

export EDITOR="vim"
bindkey -v 
export PATH=$HOME/bin:/usr/local/bin:$PATH
# export MANPATH="/usr/local/man:$MANPATH"
export POWERLINE_CONFIG_COMMAND=/Users/morgan/.vim/bundle/powerline/scripts/powerline-config
export HOMEBREW_GITHUB_API_TOKEN=22a666338b8aa4ce66c3ceb0f2151c7233f8acd4
source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
export LANG=en_US.utf8
export LC_ALL=en_US.UTF-8

# ssh wrapper that renames current tmux window to the hostname of the remote host
#ssh() {
#	tmux rename-window "$*"
#	command ssh "$@"
#	exit
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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
