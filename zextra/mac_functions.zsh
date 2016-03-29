# Mount and unmount the case-insensitive Android disk image
#
function mountAndroid() { hdiutil attach /Volumes/HDD/android.dmg -mountpoint /Volumes/android; }
function umountAndroid() { hdiutil detach /Volumes/android; }

# Get standard gitignore files for the passed in arguments
#
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

# A function that copies a zsh plugin's files to $ZSH_CUSTOM
#
function customize() {
  # local tocopy=$1
  if is_plugin $ZSH $1; then
    local plugin="${ZSH}/plugins/${1}"
    local dest="${ZSH_CUSTOM}/plugins/${1}"
    cp -r $plugin $dest && cd $dest
  fi
}

function use-ruby() {
  rvm --ruby-version use $1 --create
}

# A wrapper around less to open it with colors provided by pygments.
#
function pygless()
{
  LESSOPEN="| pygmentize -f terminal256 -O style=solarized -g %s" less -R "$@";
}

# A function that gives the current directory the alias name of the argument
# passed in, and sources the directories file to immediately show the new name
# in the prompt
#
function name-dir() {
  local dirname=$1
  if [[ $dirname == "" ]]; then
    echo "USAGE: name-dir DIR_NAME"
    return 1
  fi
  echo "hash -d ${dirname}=\"`pwd`\"" >> "${ZEXTRA_DIR}/directories.zsh"
  source "${ZEXTRA_DIR}/directories.zsh"
}
