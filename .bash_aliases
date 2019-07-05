UNAME=$(uname)
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
    which ${2%% *} 2>/dev/null 1>/dev/null
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

which dircolors >/dev/null && [ -e $SCRIPTPATH/.dir_colors ] && eval `dircolors $SCRIPTPATH/.dir_colors`

alias ls="ls -G"
[ ${UNAME}. != Darwin. ] && alias ls="ls --color"

eval `alias_helper intellij_stable /opt/intellij-ce-stable/bin/idea.sh`
eval `alias_helper intellij /opt/intellij-ce-beta/bin/idea.sh`
eval `alias_helper idea /opt/intellij-ce-beta/bin/idea.sh`
eval `alias_helper pt "pstree -ap|less"`
eval `alias_helper clion /opt/clion-beta/bin/clion.sh`
eval `alias_helper tm0 "tmx2 -2 new-session -A -s 0"`
eval `alias_helper tm1 "tmx2 -2 new-session -A -s 1 -t 0"`

function xpra_start_port() {
  if [ $# -ne 2 ]; then
    echo
    echo "Usage: "
    echo "  xpra_start_port SSH_PORT ssh:user@host:diplay_number"
    echo
  else
    PORT=$1
    shift 1
    CMD=$(which xpra)
    CMD=${CMD:-/Applications/Xpra.app/Contents/MacOS/Xpra}
    $CMD start --ssh="ssh -v -p $PORT" \
      --dpi=120 --encoding=rgb \
      --start-env="LC_ALL=en_US.UTF-8" --start-env='LANG=en_US.UTF-8' \
      --swap-keys=off --start-env="DISPLAY=:100" --start=xterm $*
  fi
}

function xpra_attach_port() {
  if [ $# -ne 2 ]; then
    echo
    echo "Usage: "
    echo "  xpra_attach_port SSH_PORT ssh:user@host:diplay_number"
    echo
  else
    PORT=$1
    shift 1
    CMD=$(which xpra)
    CMD=${CMD:-/Applications/Xpra.app/Contents/MacOS/Xpra}
    $CMD attach --ssh="ssh -v -p $PORT" \
      --dpi=120 --encoding=rgb \
      --env="LC_ALL=en_US.UTF-8" --env='LANG=en_US.UTF-8' \
      --swap-keys=off --env="DISPLAY=:100" $*
  fi
}

alias xpra_start="xpra_start_port 22"
alias xpra_attach="xpra_attach_port 22"
alias xpra_start_alt="xpra_start_port 443"
alias xpra_attach_alt="xpra_attach_port 443"

# zz
if [ ${UNAME}. = Darwin. ]; then
  # z.sh for fast directory change.
  [ -e $HOME/local/bin/z.sh ] || ( mkdir -p $HOME/local/bin && echo "Downloading z.sh ... " && \
    curl https://raw.githubusercontent.com/rupa/z/master/z.sh > $HOME/local/bin/z.sh )
  touch $HOME/.z
  source $HOME/local/bin/z.sh
else
  # z.lua for fast directory change.
  # 1. install z.lua from github
  ZLUA=$HOME/local/bin/z.lua
  [ -e $ZLUA ] || ( mkdir -p $HOME/local/bin && echo "Downloading z.lua ... " && \
    curl https://raw.githubusercontent.com/y-lu/z.lua/master/z.lua > $ZLUA )

  # 2. check lua
  if which lua5.3 >/dev/null; then
    eval "$(lua5.3 $ZLUA --init ${SHELL##*/})"
  else
    echo "To use zlua, please install lua first with this command: sudo apt-get install lua5.3"
  fi
fi

# works with z.lua
function zz() {
  if [[ $# -eq 0 ]]; then
    z -i google
  else
    z -i "$*"
  fi
  pushd 2>&1 >/dev/null
  popd  2>&1 >/dev/null
}
[ ${UNAME}. = Darwin. ] && function zz() { z "$*"; }
