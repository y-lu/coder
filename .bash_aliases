alias va="vi ~/.bash_aliases; . ~/.bash_aliases"
#export PS1="\u@:\w\$ "
export PS1="\[\033[38;3;4;27m\]\u@:\w\$\[\033[0m\] "

function helper() {
  echo Running: ${*}
  eval "$*"
}

function print_colors() {
  color=16;
  while [ $color -lt 245 ]; do
    echo -e "$color: \\033[38;5;${color}mhello\\033[48;5;${color}mworld\\033[0m"
    ((color++));
  done
}

eval `dircolors ~/.dir_colors`

alias ls="ls --color"
