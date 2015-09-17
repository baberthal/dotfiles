DISABLE_AUTO_UPDATE="true"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"

bindkey -v
export HOMEBREW_GITHUB_API_TOKEN=22a666338b8aa4ce66c3ceb0f2151c7233f8acd4

typeset -U PATH

export PATH=$HOME/bin:/Applications/Postgres.app/Contents/Versions/9.4/bin:/usr/local/bin:/usr/local/sbin:/usr/local/heroku/bin:$PATH
export GOROOT=$HOME/golang
export PATH=$PATH:$GOROOT/bin
export ANDROID_HOME=$HOME/projects/android/sdk

export USE_CCACHE=1
