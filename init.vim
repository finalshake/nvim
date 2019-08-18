
 "
  "____  _           _        _      __     _____ __  __ ____   ____ 
 "/ ___|| |__   __ _| | _____( )___  \ \   / /_ _|  \/  |  _ \ / ___|
 "\___ \| '_ \ / _` | |/ / _ \// __|  \ \ / / | || |\/| | |_) | |    
  "___) | | | | (_| |   <  __/ \__ \   \ V /  | || |  | |  _ <| |___ 
 "|____/|_| |_|\__,_|_|\_\___| |___/    \_/  |___|_|  |_|_| \_\\____|
                                                                   
                                                                   
set fileencodings=utf8,cp936,gb18030,big5

"===
"===Auto load for first time uses
"===Install the vim-plug
"===
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"===
"===general settings
"===for the sake of plug
"===
set nocompatible
filetype on
filetype indent on
"enable syntax highlight
filetype plugin on
filetype plugin indent on
syntax enable
syntax on

set encoding=utf-8
"Prevent incorrect backgrounding rendering
let &t_ut=''

set clipboard=unnamed

"Main code display
"#display line number
set number
set ruler
set cursorline
set t_Co=256
"colorscheme molokai

"set tab length
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
"set auto tab
set ai

"list
set list
set listchars=tab:▸\ ,trail:▫
set scrolloff=5
"Prevent auto line split
set wrap
set tw=0

set indentexpr=
set backspace=indent,eol,start
set foldmethod=indent
set foldlevel=99
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

"Status/command bar
set laststatus=2
set autochdir
set showcmd
set formatoptions-=tc

"Command autocomplete
set wildignore=log/**,node_modules/**,target/**,tmp/**,*.rbc
set wildmenu
set wildmode=longest,list,full

"Restore cursor position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

"Basic mapping
"Leader
let mapleader=" "

map s <nop>
map <F5> :source $MYVIMRC<CR>
noremap J 5j
noremap K 5k
map ; :

"Copy to system clipboard
vnoremap Y :w !xclip -i -sel c<CR>

"H key: go to the start of the line
noremap <C-h> 0
"L key: go to the end of the line
noremap <C-l> $

"Split
map sl :set splitright<CR>:vsplit<CR>
map sh :set nosplitright<CR>:vsplit<CR>
map sk :set nosplitbelow<CR>:split<CR>
map sj :set splitbelow<CR>:split<CR>

map <LEADER>h <C-w>h
map <LEADER>j <C-w>j
map <LEADER>k <C-w>k
map <LEADER>l <C-w>l

map <up> :res +5<CR>
map <down> :res -5<CR>
map <left> :vertical resize-5<CR>
map <right> :vertical resize+5<CR>

map sV <C-w>t<C-w>H
map sH <C-w>t<C-w>K

"vim table
map tn :tabe<CR>
map th :-tabnext<CR>
map tl :+tabnext<CR>

"Duplicate words
map <LEADER>fd /\(\<\w\+\>\)\_s*\1

"spell check with <Space>sc
map <LEADER>sc :set spell!<CR>
noremap <C-x> ea<C-x>s
inoremap <C-x> <Esc>ea<C-x>s

"placeholder press space twice to jump to the next '<++>' and edit it
map <LEADER><LEADER> <Esc>/<++><CR>:nohlsearch<CR>c4l

" Auto change directory to current dir
autocmd BufEnter * silent! lcd %:p:h

"set search
set hlsearch
exec "nohlsearch"
set incsearch
set ignorecase
set smartcase
noremap <LEADER><CR> :nohlsearch<CR>

" Compile function
map r :call CompileRunGcc()<CR>
func! CompileRunGcc()
  exec "w"
  if &filetype == 'c'
    exec "!g++ % -o %<"
    exec "!time ./%<"
  elseif &filetype == 'cpp'
    exec "!g++ % -o %<"
    exec "!time ./%<"
  elseif &filetype == 'java'
    exec "!javac %"
    exec "!time java %<"
  elseif &filetype == 'sh'
    :!time bash %
  elseif &filetype == 'python'
    set splitright
    :vsp
    :vertical resize-20
    :term python3 %
  elseif &filetype == 'html'
    exec "!firefox % &"
  elseif &filetype == 'markdown'
    exec "MarkdownPreview"
  endif
endfunc

"vim-plug settings
call plug#begin('~/.config/nvim/plugged')
"Appearance
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'connorholyday/vim-snazzy'
"Plug 'NLKNguyen/papercolor-theme'
"Plug 'ayu-theme/ayu-vim'
Plug 'bling/vim-bufferline'
Plug 'liuchengxu/space-vim-theme'

" File navigation
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ctrlpvim/ctrlp.vim', { 'on': 'CtrlP' }

" Taglist
Plug 'majutsushi/tagbar', { 'on': 'TagbarOpenAutoClose' }

" Error checking
"Plug 'w0rp/ale'

" Auto Complete
"Plug 'Valloric/YouCompleteMe'
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
"python
Plug 'ncm2/ncm2-jedi'
"general
Plug 'ncm2/ncm2-github'
Plug 'ncm2/ncm2-bufword'
Plug 'ncm2/ncm2-path'
"markdown
Plug 'ncm2/ncm2-match-highlight'
Plug 'ncm2/ncm2-markdown-subscope'
"C/C++
Plug 'ncm2/ncm2-pyclang'
"html
Plug 'ncm2/ncm2-html-subscope'

" Language Server
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

" fzf
Plug 'junegunn/fzf'

" Undo Tree
Plug 'mbbill/undotree/'

" Other visual enhancement
Plug 'nathanaelkane/vim-indent-guides'
Plug 'itchyny/vim-cursorword'
Plug 'tmhedberg/SimpylFold'
Plug 'mhinz/vim-startify'

" Git
Plug 'rhysd/conflict-marker.vim'
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'gisphm/vim-gitignore', { 'for': ['gitignore', 'vim-plug'] }

" HTML, CSS, JavaScript, PHP, JSON, etc.
Plug 'elzr/vim-json'
Plug 'hail2u/vim-css3-syntax'
Plug 'spf13/PIV', { 'for' :['php', 'vim-plug'] }
Plug 'gko/vim-coloresque', { 'for': ['vim-plug', 'php', 'html', 'javascript', 'css', 'less'] }
Plug 'pangloss/vim-javascript', { 'for' :['javascript', 'vim-plug'] }
Plug 'mattn/emmet-vim'

" Python
Plug 'vim-scripts/indentpython.vim'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}

" Markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for' :['markdown', 'vim-plug'] }
Plug 'dhruvasagar/vim-table-mode', { 'on': 'TableModeToggle' }
Plug 'vimwiki/vimwiki'

" Bookmarks
Plug 'kshenoy/vim-signature'

" For general writing
Plug 'reedes/vim-wordy'

" Other useful utilities
Plug 'jiangmiao/auto-pairs'
Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/goyo.vim' " distraction free writing mode
Plug 'tpope/vim-surround' " type ysks' to wrap the word with '' or type cs'` to change 'word' to `word`
Plug 'godlygeek/tabular' " type ;Tabularize /= to align the =
Plug 'gcmt/wildfire.vim' " in Visual mode, type i' to select all text in '', or type i) i] i} ip
Plug 'scrooloose/nerdcommenter' " in <space>cc to comment a line

" Dependencies
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'kana/vim-textobj-user'
Plug 'fadein/vim-FIGlet'

call plug#end()

" ===
" === Create a _machine_specific.vim file to adjust machine specific stuff, like python interpreter location
" ===
let has_machine_specific_file = 1
if empty(glob('~/.config/nvim/_machine_specific.vim'))
  let has_machine_specific_file = 0
  silent! exec "!cp ~/.config/nvim/default_configs/_machine_specific_default.vim ~/.config/nvim/_machine_specific.vim"
endif
source ~/.config/nvim/_machine_specific.vim


"Nerdtree setting
map <F4> :NERDTreeToggle<CR>

"colorscheme
"map <LEADER>c1 :set background=dark<CR>:colorscheme snazzy<CR>:AirlineTheme dracula<CR>
"map <LEADER>c2 :set background=light<CR>:colorscheme ayu<CR>:AirlineTheme ayu_light<CR>

set termguicolors     " enable true colors support
"let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme
"colorscheme snazzy
"let g:SnazzyTransparent = 1
"set background=dark
let g:space_vim_transp_bg = 1
colorscheme space_vim_theme
let g:airline_theme='dracula'

let g:lightline = {
  \     'active': {
  \         'left': [['mode', 'paste' ], ['readonly', 'filename', 'modified']],
  \         'right': [['lineinfo'], ['percent'], ['fileformat', 'fileencoding']]
  \     }
  \ }

"Vim-airline symbols settings
if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif

    " unicode symbols
    let g:airline_left_sep = '»'
    let g:airline_left_sep = '▶'
    let g:airline_right_sep = '«'
    let g:airline_right_sep = '◀'
    let g:airline_symbols.crypt = '🔒'
    let g:airline_symbols.linenr = '☰'
    let g:airline_symbols.linenr = '␊'
    let g:airline_symbols.linenr = '␤'
    let g:airline_symbols.linenr = '¶'
    let g:airline_symbols.maxlinenr = ''
    let g:airline_symbols.maxlinenr = '㏑'
    let g:airline_symbols.branch = '⎇'
    let g:airline_symbols.paste = 'ρ'
    let g:airline_symbols.paste = 'Þ'
    let g:airline_symbols.paste = '∥'
    let g:airline_symbols.spell = 'Ꞩ'
    let g:airline_symbols.notexists = 'Ɇ'
    let g:airline_symbols.whitespace = 'Ξ'

" ==
" == NERDTree-git
" ==
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }

" ===
" === You Complete ME
" ===
"nnoremap gd :YcmCompleter GoToDefinitionElseDeclaration<CR>
"nnoremap g/ :YcmCompleter GetDoc<CR>
"nnoremap gt :YcmCompleter GetType<CR>
"nnoremap gr :YcmCompleter GoToReferences<CR>
"let g:ycm_autoclose_preview_window_after_completion=0
"let g:ycm_autoclose_preview_window_after_insertion=1
"let g:ycm_use_clangd = 0
"let g:ycm_python_binary_path = g:ycm_python_interpreter_path

" ===
" === NCM2
" ===
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>": "\<CR>")
autocmd BufEnter * call ncm2#enable_for_buffer()
set completeopt=noinsert,menuone,noselect
let ncm2#popup_delay = 5
let g:ncm2#matcher = "substrfuzzy"
let g:ncm2_jedi#python_version = 3
let g:ncm2#match_highlight = 'sans-serif'

set shortmess+=c
set notimeout

" ===
" === Taglist
" ===
map <silent> T :TagbarOpenAutoClose<CR>

" ===
" === MarkdownPreview
" ===
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_browser = ''
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1
    \ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'

source ~/.config/nvim/snippits.vim

" ===
" === vim-table-mode
" ===
map <LEADER>tm :TableModeToggle<CR>

" ===
" === Python-syntax
" ===
let g:python_highlight_all = 1
" let g:python_slow_sync = 0

" ===
" === vim-indent-guide
" ===
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_color_change_percent = 1
silent! unmap <LEADER>ig
autocmd WinEnter * silent! unmap <LEADER>ig

" ===
" === vim-better-whitespace
" ===
let g:better_whitespace_enabled=0

" ===
" === Goyo
" ===
map <LEADER>gy :Goyo<CR>

" ===
" === CtrlP
" ===
map <C-p> :CtrlP<CR>
let g:ctrlp_prompt_mappings = {
  \ 'PrtSelectMove("j")':   ['<c-j>', '<down>'],
  \ 'PrtSelectMove("k")':   ['<c-k>', '<up>'],
  \ }

" ==
" == vim-multiple-cursor
" ==
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_start_word_key      = '<c-s>'
let g:multi_cursor_select_all_word_key = '<a-s>'
let g:multi_cursor_start_key           = 'g<c-s>'
let g:multi_cursor_select_all_key      = 'g<a-s>'
let g:multi_cursor_next_key            = '<c-n>'
let g:multi_cursor_prev_key            = '<c-N>'
let g:multi_cursor_skip_key            = '<C-x>'
let g:multi_cursor_quit_key            = '<Esc>'

" ===
" === Undotree
" ===
let g:undotree_DiffAutoOpen = 0
map L :UndotreeToggle<CR>

" ===
" === vim-signiture
" ===
let g:SignatureMap = {
        \ 'Leader'             :  "m",
        \ 'PlaceNextMark'      :  "m,",
        \ 'ToggleMarkAtLine'   :  "m.",
        \ 'PurgeMarksAtLine'   :  "dm-",
        \ 'DeleteMark'         :  "dm",
        \ 'PurgeMarks'         :  "dm/",
        \ 'PurgeMarkers'       :  "dm?",
        \ 'GotoNextLineAlpha'  :  "m<LEADER>",
        \ 'GotoPrevLineAlpha'  :  "",
        \ 'GotoNextSpotAlpha'  :  "m<LEADER>",
        \ 'GotoPrevSpotAlpha'  :  "",
        \ 'GotoNextLineByPos'  :  "",
        \ 'GotoPrevLineByPos'  :  "",
        \ 'GotoNextSpotByPos'  :  "mn",
        \ 'GotoPrevSpotByPos'  :  "mp",
        \ 'GotoNextMarker'     :  "",
        \ 'GotoPrevMarker'     :  "",
        \ 'GotoNextMarkerAny'  :  "",
        \ 'GotoPrevMarkerAny'  :  "",
        \ 'ListLocalMarks'     :  "m/",
        \ 'ListLocalMarkers'   :  "m?"
        \ }

" Open the _machine_specific.vim file if it has just been created
if has_machine_specific_file == 0
  exec "e ~/.config/nvim/_machine_specific.vim"
endif
