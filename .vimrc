set nocompatible
source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
"behave mswin

"mail 
source $VIMRUNTIME/vimmailr.vim
let $MYEMAIL="wangqi@ugs.com"

"outlook
source $VIMRUNTIME/outlook.vim
 let g:outlook_javascript = '$VIM\vimfiles\plugin\outlookvim.js'  

"NERD_tree
source $VIMRUNTIME/NERD_tree.vim
nmap <F2> :NERDTreeToggle<CR>
let Tlist_Exit_OnlyWindow=1
let Tlist_Show_One_File=1
"ctags
set tags=tags;
set autochdir
source $VIMRUNTIME/taglist.vim
let Tlist_Show_Menu=1
let Tlist_File_Fold_Auto_Close=1

"bash-supprot
source $VIMRUNTIME/bash-support.vim
 
"Used by winmanager {{{1
let g:NERDTree_title = "[NERDTree]"
function! NERDTree_Start()
    exe 'NERDTree'
endfunction
 
function! NERDTree_IsValid()
return 1
endfunction
set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

if has("gui_running")
  if has("gui_gtk2")
    set guifont=Inconsolata\ 13
  elseif has("gui_win32")
    set guifont=Consolas:h13:cANSI
	let g:clang_exec = '"D:\DyApps\llvm\bin\clang++.exe'
	let g:clang_user_options =' "-ID:\DyApps\MinGW\lib\gcc\mingw32\4.6.2\include\c++" "-ID:\DyApps\MinGW\lib\gcc\mingw32\4.6.2\include\c++\mingw32" "-ID:\DyApps\MinGW\lib\gcc\mingw32\4.6.2\include\c++\backward" "-ID:\DyApps\MinGW\lib\gcc\mingw32\4.6.2\include-fixed" "-ID:\DyApps\MinGW\lib\gcc\mingw32\4.6.2\include" "-ID:\DyApps\MinGW\include" 2> NUL || exit 0"'
	"full screen
	"au GUIEnter * simalt ~x
	nmap <F11> :simalt ~x<CR>
	nmap <F6> :ConqueTerm cmd<CR>
  endif
endif

colorscheme desert
set nu
set textwidth=200
set tabstop=4
set listchars=tab:>-,trail:-
autocmd FileType c,cpp  nmap <F4> zfa} | nmap <F5> zo |
autocmd FileType c,cpp,python,perl,lisp  set expandtab | set shiftwidth=4 | set list | behave xterm
autocmd FileType make     set list 
set nowrap
"set expandtab
set go+=a
set encoding=utf-8
imap <C-A> <ESC>ggvG$
imap <C-V> <S-Insert>

function MAP ()
    imap <C-H> <Left>
    imap <C-J> <Down>
    imap <C-K> <Up>
    imap <C-L> <Right>
endfunction

function UNMAP ()
    unmap <C-H> 
    unmap <C-J>
    unmap <C-K>
    unmap <C-L>
endfunction

nmap <silent>  <C-B>  :call SaveBackup()<CR

"imap <C-C> <C-S-insert>
nmap <F3> :WMT<CR>
nmap <C-Tab> :tabn<CR>. 


set splitbelow
map <C-i>   :fold<CR>.

"NX-dev
nmap <F7>  :split output.cxx \|r !qtype <S-Insert> <CR>
nmap <F9>  :split output.cxx \|r !qw <S-Insert> <CR>
nmap <F10> :split output.cxx \|r !qi <S-Insert> <CR>
nmap <F12> :!mqw <S-Insert> <CR>

"doxygen
let g:DoxygenToolkit_briefTag_pre="@Synopsis  "
let g:DoxygenToolkit_paramTag_pre="@Param "
let g:DoxygenToolkit_returnTag="@Returns   "
let g:DoxygenToolkit_blockHeader="--------------------------------------------------------------------------"
let g:DoxygenToolkit_blockFooter="----------------------------------------------------------------------------"
let g:DoxygenToolkit_authorName="Mathias Lorente"
let g:DoxygenToolkit_licenseTag="My own license"   

"win-manger
let g:winManagerWindowLayout = "NERDTree|TagList"
let g:winManagerWidth = 60
let g:defaultExplorer = 0
nmap <C-W><C-F> :FirstExplorerWindow<cr>
nmap <C-W><C-B> :BottomExplorerWindow<cr>
nmap <silent> <leader>wm :WMToggle<cr> 

