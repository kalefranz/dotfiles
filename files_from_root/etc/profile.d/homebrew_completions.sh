if [ -d /usr/local/etc/bash_completion.d ]; then
  for file in /usr/local/etc/bash_completion.d/*.sh ; do
    if [ -f "$file" ] ; then
      . "$file"
    fi
  done
fi
