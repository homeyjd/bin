##############################
# Cygwin

alias ls='ls -al --color'

export PATH=$PATH:~/bin

alias mt='multitail -CS php'

##############################
# Mac

export PATH="$PATH:/Users/jdecker/Applications"
export MYSQL_HOME=/usr/local/mysql

# CLI Colors
export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

alias subl='subl . &'
alias ls='ls -alG'

function tree {
  find "${1:-.}" -print | sed -e 's;[^/]*/;|____;g;s;____|; |;g'
}

alias mysql_start='sudo $MYSQL_HOME/support-files/mysql.server start'
alias mysql_stop='sudo $MYSQL_HOME/support-files/mysql.server stop'

