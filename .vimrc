" A vimrc based on minimal-vimrc from Wang Shidong@wsdjeg and was
" personalized by dustynight@DN-C. Feel free to give advice! 
" References:
" http://www.skywind.me/blog/archives/2084 Skywind@skywind3000 
" http://www.ruanyifeng.com/blog/2018/09/vimrc.html
" https://github.com/wsdjeg/vim-galore-zh_cn

" You want Vim, not vi. When Vim finds a vimrc, 'nocompatible' is set anyway.
" We set it explicitely to make our position clear!
set nocompatible

filetype plugin indent on  " Load plugins according to detected filetype.
syntax on                  " Enable syntax highlighting.

set autoindent             " Indent according to previous line.
set expandtab              " Use spaces instead of tabs.
set softtabstop =4         " Tab key indents by 4 spaces.
set shiftwidth  =4         " >> indents by 4 spaces.
set shiftround             " >> indents to next multiple of 'shiftwidth'.

set backspace   =indent,eol,start  " Make backspace work as you would expect.
set hidden                 " Switch between buffers without having to save first.
set laststatus  =2         " Always show statusline.
set display     =lastline  " Show as much as possible of the last line.

" set showmode               " Show current mode in command-line.
set showcmd                " Show already typed keys when more are expected.

set incsearch              " Highlight while searching with / or ?.
set hlsearch               " Keep matches highlighted.
set showmatch              " Highlight the matching parentheses while your consor meet one. 

set ttyfast                " Faster redrawing.
set lazyredraw             " Only redraw when necessary.

set splitbelow             " Open new windows below the current window.
set splitright             " Open new windows right of the current window.

set cursorline             " Find the current line quickly.
set wrapscan               " Searches wrap around end-of-file.
set report      =0         " Always report changed lines.
set synmaxcol   =200       " Only highlight the first 200 columns.

set mouse       =a         " Enable mouse.
set encoding    =utf-8     " Use utf-8.
set t_Co        =256       " Enable 256 colours.
set number         " Show the number of lines.
set noerrorbells           " Disable the error bells.
set visualbell             " Enable the visual bell.
set history     =1000      " 1000 historical operation records. 

" ban imd when in normal mode
set noimdisable

" set foldmethod
set foldenable
set fdm=indent

set list                   " Show non-printable characters.
if has('multi_byte') && &encoding ==# 'utf-8'
  let &listchars = 'tab:▸ ,extends:❯,precedes:❮,nbsp:±'
else
  let &listchars = 'tab:> ,extends:>,precedes:<,nbsp:.'
endif

" The fish shell is not very compatible to other shells and unexpectedly
" breaks things that use 'shell'.
if &shell =~# 'fish$'
  set shell=/bin/bash
endif

" If the files doesn't exist, create it. 
if !isdirectory($HOME.'/.vim/files') && exists('*mkdir')
  call mkdir($HOME.'/.vim/files')
  call mkdir($HOME.'/.vim/files/swap')
  call mkdir($HOME.'/.vim/files/undo')
  call mkdir($HOME.'/.vim/files/info')
  call mkdir($HOME.'/.vim/files/backup')
endif

" Put all temporary files under the same directory.
" https://github.com/mhinz/vim-galore#handling-backup-swap-undo-and-viminfo-files
set backup
set backupdir   =$HOME/.vim/files/backup/
set backupext   =-vimbackup
set backupskip  =
set directory   =$HOME/.vim/files/swap//
set updatecount =100
set undofile
set undodir     =$HOME/.vim/files/undo/
set viminfo     ='100,n$HOME/.vim/files/info/viminfo

" Key mapping
" Use <Space> as leader key.
let mapleader = " "

" Use <Ctrl> + c/v to copy and paste in.
vnoremap <leader><S-c> "+y
nnoremap <leader><C-v> "+p

" Use <Space>nh to set no highlight
nnoremap <leader>nh :nohl<CR>

" Use Ctrl + h/j/k/l to control the cursor in Insert Mode
inoremap <c-h> <left>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-l> <right>

" use <leader>w to save
nnoremap <leader>w :w<CR>


" -------------------------------------------------------------------------------
" All about plugin under this line.
" -------------------------------------------------------------------------------

" Install vim-plug if necessary
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Install plug
call plug#begin('~/.vim/plugged')

    " Install universal-ctags
    Plug 'universal-ctags/ctags'

    " Install nerdtree
    Plug 'scrooloose/nerdtree' 

    " Intsall vim-gutentags
    Plug 'ludovicchabant/vim-gutentags'

    " Install asyncrun
    Plug 'skywind3000/asyncrun.vim'

    " Install ALE
    Plug 'w0rp/ale'

    " Install vim-cpp-enhanced-hignlight
    Plug 'octol/vim-cpp-enhanced-highlight'
    
    " Install YouCompleteMe
    " WARNING:To install YCM completely, there are some addtional settings you need to do, see https://github.com/Valloric/YouCompleteMe
    Plug 'Valloric/YouCompleteMe'

    " Install LeaderF
    Plug 'Yggdroot/LeaderF'

    " Install echodoc
    Plug 'Shougo/echodoc.vim'

    " Install lightline
    Plug 'itchyny/lightline.vim'

    " Install delimitMate
    Plug 'Raimondi/delimitMate'

    " Install NERD commenter
    Plug 'scrooloose/nerdcommenter'

call plug#end()

" -------------------------------------------------------------------------------

" Universal-ctags setting

set tags=.//tags;,.tags

" -------------------------------------------------------------------------------

" Vim-gutentags setting
" From @skywind3000
" Personalized by @DN-C
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
 
" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'
 
" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
 
" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" -------------------------------------------------------------------------------

" asyncrun setting
" From @skywind3000

" 自动打开 quickfix window ，高度为 6
let g:asyncrun_open = 6
 
" 任务结束时候响铃提醒
let g:asyncrun_bell = 1

" Set F11 as forcing to stop AsyncRun by signal KILL
nnoremap <silent><F11> :AsyncStop!<cr>

" 设置 F10 打开/关闭 Quickfix 窗口
nnoremap <F10> :call asyncrun#quickfix_toggle(10)<cr>

" 定义 F9 为编译单文件
nnoremap <silent> <F9> :AsyncRun g++ -Wall -O2 "$(VIM_FILEPATH)" -o "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
" F5运行
nnoremap <silent> <F5> :AsyncRun -raw -cwd=$(VIM_FILEDIR) "$(VIM_FILEDIR)/$(VIM_FILENOEXT)" <cr>
" 重新定义项目标志
let g:asyncrun_rootmarks = ['.svn', '.git', '.root', '_darcs', 'build.xml'] 
" F7 编译整个项目
nnoremap <silent> <F7> :AsyncRun -cwd=<root> make <cr>
" F8 运行当前项目
nnoremap <silent> <F8> :AsyncRun -cwd=<root> -raw make run <cr>
" F6 执行测试
nnoremap <silent> <F6> :AsyncRun -cwd=<root> -raw make test <cr>
" F4 为更新 Makefile 文件(cmake)
nnoremap <silent> <F4> :AsyncRun -cwd=<root> cmake . <cr>

" -------------------------------------------------------------------------------

" ALE setting

" From @skywind3000, personnalized by dustynight@DN-C
let g:ale_linters_explicit = 1
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'
let g:ale_lint_on_insert_leave = 1
let g:airline#extensions#ale#enabled = 1
 
let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
let g:ale_c_cppcheck_options = ''
let g:ale_cpp_cppcheck_options = ''

let g:ale_linters = {
\   'python' : ['pylint'],
\   'cpp'    : ['gcc', 'clang'],
\   'c'      : ['gcc', 'clang'],
\   'java'   : ['javac'],
\   'javascript'    : ['prettier', 'eslint'],
\   'HTML'   : ['prettier'],
\   'CSS'    : ['prittier'],
\}

" -------------------------------------------------------------------------------

" LeadrF setting
noremap <leader>lff :LeaderfFunction!<CR>

" -------------------------------------------------------------------------------

" YCM setting

" Originally from @skywind3000, personalized by dustynight@DN-C
let g:ycm_confirm_extra_conf=0    
let g:ycm_add_preview_to_completeopt = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_server_log_level = 'info'
let g:ycm_min_num_identifier_candidate_chars = 2
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_complete_in_strings=1
let g:ycm_key_invoke_completion = '<c-z>'
set completeopt=menu,menuone
 
noremap <c-z> <NOP>
 
let g:ycm_semantic_triggers =  {
            \ 'c,cpp,python,java,go,erlang,perl': ['re!\w{2}'],
            \ 'cs,lua,javascript': ['re!\w{2}'],
            \ 'css': [ 're!^', 're!^\s+', ': '],
            \ 'html': [ 're!^', 're!^\s+', ': '],
            \ }

let g:ycm_filetype_whitelist = { 
\ "py":1,
\ "c":1,
\ "cpp":1, 
\ "objc":1,
\ "sh":1,
\ "zsh":1,
\ "zimbu":1,
\ "java":1,
\ "js":1,
\ "css":1,
\ "html":1,
\}

highlight PMenu ctermfg=0 ctermbg=242 guifg=black guibg=darkgrey
highlight PMenuSel ctermfg=242 ctermbg=8 guifg=darkgrey guibg=black

" -------------------------------------------------------------------------------

" echodoc setting
set noshowmode

" -------------------------------------------------------------------------------

" nerdcommenter settings
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" -------------------------------------------------------------------------------

" nerdTree settings

"F2开启和关闭树" 
map <F2> :NERDTreeToggle<CR> 
let NERDTreeChDirMode=1

"显示书签"
let NERDTreeShowBookmarks=1

" 设置忽略文件类型" 
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$'] 

"窗口大小"
let NERDTreeWinSize=30

"Close nerdTree tab automatically when it is the only last tab
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
    

    


