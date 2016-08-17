# A function that gives the current directory the alias name of the argument
# passed in, and sources the directories file to immediately show the new name
# in the prompt
#
function name-dir {
  local dirname=$1
  if [[ $dirname == "" ]]; then
    echo "USAGE: name-dir DIR_NAME"
    return 1
  fi
  echo "hash -d ${dirname}=\"`pwd`\"" >> "${ZEXTRA_DIR}/directories.zsh"
  source "${ZEXTRA_DIR}/directories.zsh"
}
