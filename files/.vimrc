set encoding=UTF-8

scriptencoding utf-8

syntax on
set termencoding=UTF-8 "文字コードをUTF-8にする
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set fileformats=unix,dos,mac

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif
" Required:
let s:dein_dir = '$HOME/.cache/dein'
let s:dein_github = s:dein_dir . '/repos/github.com'
let s:dein_repo_name = 'Shougo/dein.vim'
let s:dein_repo_dir = expand(s:dein_github . '/' . s:dein_repo_name)

" Check dein has been installed or not.
if !isdirectory(s:dein_repo_dir)
  echo 'dein is not installed, install now '
  let s:dein_repo = 'https://github.com/' . s:dein_repo_name
  echo 'git clone ' . s:dein_repo . ' ' . s:dein_repo_dir
  call system('git clone ' . s:dein_repo . ' ' . s:dein_repo_dir)
endif

set runtimepath+=$HOME/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  let s:rc_dir = expand('~/.vim')
  if !isdirectory(s:rc_dir)
    call makedir(s:rc_dir, 'p')
  endif
  let s:toml      = s:rc_dir . '/dein.toml'
  let s:toml_lazy = s:rc_dir . '/dein_lazy.toml'

  call dein#load_toml(s:toml     , {'lazy': 0})
  call dein#load_toml(s:toml_lazy, {'lazy': 1})

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

"Open 1 terminal
function! TermOpen()
    if empty(term_list())
        execute "terminal"
    else
        call win_gotoid(win_findbuf(term_list()[0])[0])
    endif
endfunction

" coc completion settings (from: README of coc)
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" end coc settings

" Please highlight zenkaku space
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermfg=darkgrey gui=underline guifg=darkgrey
endfunction

if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    " ZenkakuSpaceをカラーファイルで設定するなら次の行は削除
    autocmd ColorScheme       * call ZenkakuSpace()
    " 全角スペースのハイライト指定
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    autocmd VimEnter,WinEnter * match ZenkakuSpace '\%u3000'
  augroup END
  call ZenkakuSpace()
endif

" always shows statusline
set laststatus=2
let g:airline_powerline_fonts = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#whitespace#mixed_indent_algo = 1
if 0 
    " Powerline系フォントを利用する
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
    let g:airline_symbols.notexists = '∄'
    let g:airline_symbols.whitespace = 'Ξ'
    
    " powerline symbols
    let g:airline_left_sep = ''
    let g:airline_left_alt_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ''
    let g:airline_symbols.branch = ''
    let g:airline_symbols.readonly = ''
    let g:airline_symbols.linenr = '☰'
    let g:airline_symbols.maxlinenr = ''
endif

" truecolor
if has('nvim')
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

highlight SpecialKey guibg=NONE guifg=Gray
set backspace=indent,eol,start " バックスペースでインデントや改行を削除できるようにする
set nowrap            " ターミナルの右端で文字を折り返さない
set hlsearch          " ハイライトサーチを有効にする。文字列検索は /word とか * ね
set ignorecase        " 大文字小文字を区別しない(検索時)
set smartcase         " ただし大文字を含んでいた場合は大文字小文字を区別する(検索時)
set ruler             " カーソル位置が右下に表示される
set number            " 行番号を付ける
set list              " タブ文字の表示 ^I で表示されるよ
set listchars=tab:»-,trail:-,nbsp:%,eol:↲
set wildmenu          " コマンドライン補完が強力になる
set showcmd           " コマンドを画面の最下部に表示する
set clipboard=unnamed " クリップボードを共有する(設定しないとvimとのコピペが面倒です)
set autoindent        " 改行時にインデントを引き継いで改行する
set shiftwidth=4      " インデントにつかわれる空白の数
set softtabstop=4     " <Tab>押下時の空白数
set expandtab         " <Tab>押下時に<Tab>ではなく、ホワイトスペースを挿入する
set tabstop=4         " <Tab>が対応する空白の数
set nf=hex            " インクリメント、デクリメントを16進数にする(0x0とかにしなければ10進数です。007をインクリメントすると010になるのはデフォルト設定が8進数のため)
set mouse=a           " マウス使えます
set hidden
let IM_CtrlMode = 0
set iminsert=0
set imsearch=-1
set cmdheight=2
set termguicolors
if $TERM == "screen-256color"
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif
set splitbelow
let NERDTreeWinSize=20
set noswapfile
set nobackup
set noundofile
set visualbell t_vb=
set noerrorbells
let g:coc_disable_startup_warning = 1
let g:airline_theme = 'molokai'

" [ って打ったら [] って入力されてしかも括弧の中にいる(以下同様)
imap [ []<left>
imap ( ()<left>
imap { {}<left>
imap < <><left>
inoremap " ""<left>
inoremap ' ''<left>
imap < <><left>
"Ctrl+HJKLで動きたい
imap <C-h> <left>
imap <C-j> <down>
imap <C-k> <up>
imap <C-l> <right>
nmap <Esc><Esc> :nohlsearch<CR><Esc>
nmap <C-@> :call TermOpen()<CR><C-w>k10<C-w>+
nmap <C-p> :call TermOpen()<CR><C-w>k10<C-w>+
nmap <C-b> :NERDTree<CR>
