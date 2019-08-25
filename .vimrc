set nocompatible
syntax on
set backup backupdir=$HOME/.vim/tmp/backup

let mapleader=" "
nnoremap <Space> <Nop>

execute pathogen#infect()

"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"map <C-n> :NERDTreeToggle<CR>

function! SetFileNameToFirstLine()
  echo "Filename set to first line."
  silent execute "file ~/.vim/backup/".fnameescape(substitute(substitute(getline(1),'\s','_', 'g'), '[^a-zA-Z0-9_]', '', 'g')).strftime("-saved-%Y-%m-%d_%H-%M.txt")
endfunction
nnoremap <F9> :call SetFileNameToFirstLine()<CR>

"let s:set_file_name_to_first_line_active = 0
"function! ToggleSetFileNameToFirstLine()
"  if s:set_file_name_to_first_line_active
"    silent! augroup! SFNTFL
"    echo "SetFileNameToFirstLine disabled"
"  else
"    augroup SFNTFL
"      au! InsertLeave,CursorHold,CursorHoldI <buffer> call SetFileNameToFirstLine()
"    augroup END
"    call SetFileNameToFirstLine()
"    echo "SetFileNameToFirstLine enabled"
"  endif
"  let s:set_file_name_to_first_line_active = !s:set_file_name_to_first_line_active
"endfunction
"nnoremap <F9> :call ToggleSetFileNameToFirstLine()<CR>

:packadd vim-signify

" menu in terminal. see: https://unix.stackexchange.com/questions/43526/is-it-possible-to-create-and-use-menus-in-terminal-based-vim
set wildmenu
set wildmode=full
source $VIMRUNTIME/menu.vim
set wildcharm=<Tab>
map <F10> :emenu <Tab>

set mouse=a
