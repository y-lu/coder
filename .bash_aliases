## Set up SCRIPTPATH to the folder containing this script
## Ref for zsh: https://stackoverflow.com/questions/9901210/bash-source0-equivalent-in-zsh
[ ${ZSH_VERSION}.  != . ] && export SCRIPTPATH=${(%):-%x}} && export SCRIPTPATH=${SCRIPTPATH%/*}
[ ${BASH_VERSION}. != . ] && export SCRIPTPATH=${BASH_SOURCE%/*}
#echo SCRIPTPATH=$SCRIPTPATH

alias va="vi $SCRIPTPATH/.bash_aliases; . $SCRIPTPATH/.bash_aliases"

# should do the following just for bash
[ ${BASH_VERSION}. != . ] && export PS1="\[\033[38;3;4;27m\]\u@:\w\$\[\033[0m\] "
#export PS1="\u@:\w\$ "

# Print the actual command line then run it.
function helper() {
  echo Running: ${*}
  eval "$*"
}

# Only create alias if the binary is present.
function alias_helper() {
  if [ $# -eq 2 ]; then
    A=$1
    B=$2
    which ${2%% *} 2>&1 >/dev/null
    [ $? -eq 0 ] && echo alias $A=\"helper $B\"
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

eval `alias_helper intellij_stable /opt/intellij-ce-stable/bin/idea.sh`
eval `alias_helper intellij /opt/intellij-ce-beta/bin/idea.sh`
eval `alias_helper idea /opt/intellij-ce-beta/bin/idea.sh`
eval `alias_helper pt "pstree -ap|less"`
eval `alias_helper clion /opt/clion-beta/bin/clion.sh`
eval `alias_helper tm0 "tmx2 -2 new-session -A -s 0"`
eval `alias_helper tm1 "tmx2 -2 new-session -A -s 1 -t 0"`
