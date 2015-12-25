" SAVE's vimset" >

set autoindent
set shiftwidth=4
set nu
set tabstop=4
set nobackup

"use mouse
set mouse=a
set mousem=popup

"Shortcut Key
"map <F2> :w!<CR>
"map <F5> :! gcc % -o %<<CR>
"map <F4> :! ./%<<CR>
let Tlist_Use_Right_Window=1
let Tlist_Auto_Open=0
nmap <F9> :Tlist<CR>
nmap <F7> :NERDTreeToggle<CR>
nmap <F10> :SrcExplToggle<CR>
nmap <F8> :ConqueTermSplit bash<CR>
nmap <F12> <C-w>o

"for... python
syntax on
"filetype indent plugin on
filetype plugin indent on
let python_version_2 = 1
let python_highlight_all = 1

set history=1000

"plugin set
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"let g:ConqueTerm_SendFunctionKeys=0
let g:ConqueTerm_ToggleKey='<C-w><F8>'

let g:syntastic_python_checkers=['python']
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0

"using super tab
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType='<C-n>'
let g:SuperTabCrMapping=0
"UltiSnipsExpandTrigger
let g:UltiSnipsExandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsUsePythonVersion=2
let g:UltiSnipsDirectories=['UltiSnips', 'ultisnips', 'snips']

"let g:ycm_use_ultisnips_completer=1
let g:ycm_autoclose_preview_window_after_completion=1
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>

colorscheme molokai
" highlight Normal guibg=black guifg=white
set background=dark
set t_Co=256

"plugin
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#rc()

"Plugin
Plugin 'gmarik/Vundle.vim'
Plugin 'wincent/command-t'
Plugin 'lrvick/Conque-Shell'
Plugin 'scrooloose/nerdtree'
Plugin 'taglist-plus'
Plugin 'SrcExpl'
Plugin 'taketwo/vim-ros'
Plugin 'Valloric/YouCompleteMe'
Plugin 'SirVer/ultisnips'
Plugin 'scrooloose/syntastic'
Plugin 'ervandew/supertab'
Plugin 'honza/vim-snippets'

filetype plugin indent on
