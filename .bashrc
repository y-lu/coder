export PATH=/clang_8.0.0/bin:$PATH
export LD_LIBRARY_PATH=/clang_8.0.0/lib:LD_LIBRARY_PATH
#export PS1="\u@:\w\$ "
export PS1="\[\033[38;4;27m\]\u@:\w\$\[\033[0m\] "

if [ -e $HOME/.bash_aliases ]; then
        . $HOME/.bash_aliases
fi
