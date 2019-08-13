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
  silent execute "file ~/.vim/backup/".fnameescape(getline(1)).strftime("-saved-%Y-%m-%d_%H-%M.txt")
endfunction

let s:set_file_name_to_first_line_active = 0
function! ToggleSetFileNameToFirstLine()
  if s:set_file_name_to_first_line_active
    silent! augroup! SFNTFL
    echo "SetFileNameToFirstLine disabled"
  else
    augroup SFNTFL
      au! InsertLeave,CursorHold,CursorHoldI <buffer> call SetFileNameToFirstLine()
    augroup END
    call SetFileNameToFirstLine()
    echo "SetFileNameToFirstLine enabled"
  endif
  let s:set_file_name_to_first_line_active = !s:set_file_name_to_first_line_active
endfunction

nnoremap <F9> :call ToggleSetFileNameToFirstLine()<CR>

:packadd vim-signify
