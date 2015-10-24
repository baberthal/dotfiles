DISABLE_AUTO_UPDATE="true"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"

bindkey -v
export HOMEBREW_GITHUB_API_TOKEN=5aef3e59bef53a9c6eca10198b2b8198f3dff6b9
typeset -U PATH

export PATH=${HOME}/bin:/Applications/Postgres.app/Contents/Versions/9.4/bin:/usr/local/bin:/usr/local/sbin:/usr/local/heroku/bin:${PATH}
export PATH=${PATH}:${JBOSS_HOME}/bin
export GOPATH=${HOME}/golang
export GOROOT=/usr/local/opt/go/libexec
export PATH=${PATH}:${GOPATH}/bin
export PATH=${PATH}:${GOROOT}/bin
export ANDROID_HOME=$HOME/projects/android/sdk
export JBOSS_HOME=/usr/local/opt/jboss-as/libexec
export JAVA_HOME="$(/usr/libexec/java_home)"

export USE_CCACHE=1

fpath=(${ZSH_CUSTOM}/functions.zsh ${ZSH_CUSTOM}/functions $fpath)
# source $ZSH_CUSTOM/functions.zsh
