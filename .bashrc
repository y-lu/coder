[ -e /clang_8.0.0/bin ] && export PATH=/clang_8.0.0/bin:$PATH
[ -e /clang_8.0.0/bin ] && export LD_LIBRARY_PATH=/clang_8.0.0/lib:LD_LIBRARY_PATH

SCRIPTPATH=$(dirname ${BASH_SOURCE})
[ -e $SCRIPTPATH/.bash_aliases ] && . $SCRIPTPATH/.bash_aliases
