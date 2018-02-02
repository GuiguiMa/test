if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
"set ai			" always set autoindenting on
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set mouse=a
set number
"set cc=81
set cul 
set ve=all

if has("syntax")
syntax on
endif
colorscheme ron
set tabstop=4
set shiftwidth=4
set linebreak
set history=50
set cindent
set cinoptions={0,1s.t0.n-2,p2s,(03s,=.5s,>1s,=1s,:1s
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
   set termencoding=utf-8
      set encoding=utf-8
" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup redhat
  autocmd!
  " In text files, always limit the width of text to 78 characters
  " autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/run/media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add $PWD/cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

filetype plugin on

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"
"addational settings
"General {
" tags=~/linux-pnfs/tags 
" tags+=~/bwfskmod/tags 
" filetype plugin indent on 
set autoindent 
set cindent 
" set iskeyword+=_,$,@,%,# 
 set noerrorbells 
" set whichwrap=b,s,h,l,<,>,~,[,]
 set wildmenu 
 set wildignore=*.dll,*.o,*.obj,*.bak,*.exe,*.pyc,
 \*.jpg,*.gif,*.png
" set wildmode=list:longest
" }
"TagList Settings {
 "let Tlist_Auto_Open=1 " let the tag list open automagically
 let Tlist_Compact_Format = 1 " show small menu
 let Tlist_Ctags_Cmd = 'ctags'
 let Tlist_Enable_Fold_Column = 0
 let Tlist_Exist_OnlyWindow = 1
 let Tlist_File_Fold_Auto_Close = 0
" let Tlist_Sort_Type = "name" 排序依据
 let Tlist_WinWidth = 30 
 let Tlist_Show_One_File = 1
 let Tlist_Exit_OnlyWindow=1
" let Tlist_Ctags_Cmd="user/bin/ctags"
" " }

" cscope setting
 if has("cscope")
 set csprg=/usr/local/bin/cscope
 set csto=1
 set cscopetagorder=1
 set cst
 set nocsverb
 "add any database in current directory
 if filereadable("cscope.out")
 cs add cscope.out
 endif
 set csverb
 endif
 set cscopequickfix=s-,c-,d-,i-,t-,e-
 nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
 nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
 nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
 nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
 nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
 nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
 nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
 nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>
 "nmap <C-_>h ? <C-R>=expand("<cword>")<CR><CR>
 map<F12> :!make <CR>
 """""""""""""""""""""""""""""""""""""""""""
 "F5 complie and run c program             "
 """""""""""""""""""""""""""""""""""""""""""
 map<F5> :call CompileRunGcc()<CR>
 func! CompileRunGcc()
 exec "w"
 exec "!gcc % -o %<"
 exec "! ./%<"
 endfunc


 "======折叠======
 set foldmethod=syntax
 set foldlevel=100
 set foldcolumn=5
 """""""""""""""""""""""""""""""""""""""""""""""
 "窗口winmanager "
 """""""""""""""""""""""""""""
let g:winManagerWindowLayout = 'FileExplorer|Taglist'
let g:winManagerWidth = 30
nmap <F8> :WMToggle<cr>
let g:AutoOpenWinManager=1
