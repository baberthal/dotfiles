function rails {
  if [ -e "bin/rails" ]; then
    bin/rails $@
  elif [ -d ".bundle" ]; then
    command bundle exec rails $@
  else
    command rails $@
  fi
}
