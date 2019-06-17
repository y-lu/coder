#echo BASH_SOURCE=$BASH_SOURCE
SCRIPTPATH=${BASH_SOURCE%/*}
#echo SCRIPTPATH=$SCRIPTPATH
alias va="vi $SCRIPTPATH/.bash_aliases; . $SCRIPTPATH/.bash_aliases"
#export PS1="\u@:\w\$ "
export PS1="\[\033[38;3;4;27m\]\u@:\w\$\[\033[0m\] "

function helper() {
  echo Running: ${*}
  eval "$*"
}

function alias_helper() {
  if [ $# -eq 2 ]; then
    A=$1
    B=$2
    which ${2%% *} 2>&1 >/dev/null
    [ $? -eq 0 ] && echo alias $A=\"$B\"
    #echo $A $B $CMD
  else
    true
    #echo echo Usage:
    #echo echo alias_helper NAME \"PROGRAM ARG1 ARG2 ...\"
    #echo echo
  fi
}

function print_colors() {
  color=16;
  while [ $color -lt 245 ]; do
    echo -e "$color: \\033[38;5;${color}mhello\\033[48;5;${color}mworld\\033[0m"
    ((color++));
  done
}

[ -e $SCRIPTPATH/.dir_colors ] && eval `dircolors $SCRIPTPATH/.dir_colors`

alias ls="ls --color"
eval `alias_helper intellij /opt/intellij-ce-stable/bin/idea.sh`
eval `alias_helper pt "pstree -ap|less"`
