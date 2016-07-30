DISABLE_AUTO_UPDATE="true"
DISABLE_AUTO_TITLE="true"
ENABLE_CORRECTION="true"

export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'
bindkey -v

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export KEYTIMEOUT=1
export LESS='-F -g -i -M -R -S -w -X -z-4'

export GOPATH=${HOME}/golang
export GOROOT=/usr/local/opt/go/libexec
export JBOSS_HOME=/usr/local/opt/jboss-as/libexec
export GROOVY_HOME=/usr/local/opt/groovy/libexec
export ECLIPSE_HOME="${HOME}/Applications/Eclipse.app/Contents/Eclipse"

typeset -gU PATH
path=(
    ${HOME}/bin
    /usr/local/{bin,sbin,heroku/bin}
    /Applications/Postgres.app/Contents/Versions/9.5/bin
    /Applications/Xcode.app/Contents/Developer/usr/bin
    $path
    ${JBOSS_HOME}/bin
    ${HOME}/Library/Developer
    ${GOPATH}/bin
    ${GOROOT}/bin
)

export ANDROID_HOME=$HOME/projects/android/sdk

if [[ -x /usr/libexec/java_home ]]; then
    export JAVA_HOME="$(/usr/libexec/java_home)"
fi

if [[ -f "${HOME}/.env" ]]; then
    source "${HOME}/.env"
fi

export USE_CCACHE=1

fpath=(${ZSH_CUSTOM}/functions.zsh ${ZSH_CUSTOM}/functions $fpath)
# source $ZSH_CUSTOM/functions.zsh

man() {
        env \
          LESS_TERMCAP_mb=$(printf "\e[1;35m") \
          LESS_TERMCAP_md=$(printf "\e[1;34m") \
          LESS_TERMCAP_me=$(printf "\e[0m") \
          LESS_TERMCAP_se=$(printf "\e[0m") \
          LESS_TERMCAP_so=$(printf "\e[1;43;37m") \
          LESS_TERMCAP_ue=$(printf "\e[0m") \
          LESS_TERMCAP_us=$(printf "\e[1;4;36m") \
                PAGER="${commands[less]:-$PAGER}" \
                _NROFF_U=1 \
                PATH="$HOME/bin:$PATH" \
                        man "$@"
}

export NVMDIR="${HOME}/.nvm"
[[ -s "${NVMDIR}/nvm.sh" ]] && . "${NVMDIR}/nvm.sh"
