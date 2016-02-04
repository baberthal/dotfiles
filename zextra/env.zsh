DISABLE_AUTO_UPDATE="true"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"

bindkey -v
typeset -U PATH



export PATH=${HOME}/bin:/Applications/Postgres.app/Contents/Versions/9.5/bin:/usr/local/bin:/usr/local/sbin:/usr/local/heroku/bin:/Applications/Xcode.app/Contents/Developer/usr/bin:${PATH}
export PATH=${PATH}:${JBOSS_HOME}/bin:${HOME}/Library/Developer
export GOPATH=${HOME}/golang
export GOROOT=/usr/local/opt/go/libexec
export PATH=${PATH}:${GOPATH}/bin
export PATH=${PATH}:${GOROOT}/bin
export ANDROID_HOME=$HOME/projects/android/sdk
export JBOSS_HOME=/usr/local/opt/jboss-as/libexec

if [[ -x /usr/libexec/java_home ]]; then
    export JAVA_HOME="$(/usr/libexec/java_home)"
fi

if [[ -f "${HOME}/.env" ]]; then
    source "${HOME}/.env"
fi

export USE_CCACHE=1

fpath=(${ZSH_CUSTOM}/functions.zsh ${ZSH_CUSTOM}/functions $fpath)
# source $ZSH_CUSTOM/functions.zsh
