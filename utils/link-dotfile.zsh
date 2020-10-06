################################################################################
#                                 link-dotfile                                 #
################################################################################
#
# Copyright (c) 2019 J. Morgan Lieberthal <j.morgan.lieberthal@gmail.com>
#
# USAGE::
#   link-dotfile [OPTIONS] dotfile_name [target_file]
#   ln-dotfile [OPTIONS] dotfile_name [target_file]
#

function link-dotfile {
  local dotfile_name=${1:?"Usage: $0 [options] dotfile_name [target_file]"}
  [[ -z "${DEBUG}" ]] && echo "dotfile_name: ${dotfile_name}"
}

alias ln-dotfile="link-dotfile"
alias lndot="link-dotfile"
