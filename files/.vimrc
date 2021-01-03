scriptencoding utf-8

function! TermOpen()
    if empty(term_list())
        execute "terminal"
    else
        call win_gotoid(win_findbuf(term_list()[0])[0])
    endif
endfunction

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
if dein#load_state('$HOME/.cache/dein')
  call dein#begin('$HOME/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('$HOME/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('flazz/vim-colorschemes')
  call dein#add('Shougo/Denite.nvim')
  call dein#add('tpope/vim-fugitive')
  call dein#add('vim-airline/vim-airline')
  call dein#add('vim-airline/vim-airline-themes')
  call dein#add('neoclide/coc.nvim', {'merged':0, 'rev': 'release'})
  call dein#add('preservim/nerdtree')
  call dein#add('ujihisa/unite-colorscheme')

  " You can specify revision/branch/tag.
  " call dein#add('Shougo/deol.nvim', { 'rev': '01203d4c9' })
  call dein#add('Shougo/deol.nvim')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

let g:neocomplete#enable_at_startup = 1

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

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

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
     
"左側に使用されるセパレータ
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
"右側に使用されるセパレータ
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols.crypt = '🔒'		"暗号化されたファイル
let g:airline_symbols.linenr = '¶'			"行
let g:airline_symbols.maxlinenr = '㏑'		"最大行
let g:airline_symbols.branch = '⭠'		"gitブランチ
let g:airline_symbols.paste = 'ρ'			"ペーストモード
let g:airline_symbols.spell = 'Ꞩ'			"スペルチェック
let g:airline_symbols.notexists = '∄'		"gitで管理されていない場合
let g:airline_symbols.whitespace = 'Ξ'	"空白の警告(余分な空白など)

" truecolor
if has('patch-7.4.1778')
    "set guicolors
endif
if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif


syntax on
set encoding=UTF-8 "文字コードをUTF-8にする
set termencoding=UTF-8 "文字コードをUTF-8にする
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set fileformats=unix,dos,mac
highlight SpecialKey guibg=NONE guifg=Gray
set backspace=indent,eol,start " バックスペースでインデントや改行を削除できるようにする
set nowrap            " ターミナルの右端で文字を折り返さない
set hlsearch          " ハイライトサーチを有効にする。文字列検索は /word とか * ね
set ignorecase        " 大文字小文字を区別しない(検索時)
set smartcase         " ただし大文字を含んでいた場合は大文字小文字を区別する(検索時)
set ruler             " カーソル位置が右下に表示される
set number            " 行番号を付ける
set list              " タブ文字の表示 ^I で表示されるよ
set listchars="tab:»-,trail:-,nbsp:%,eol:↲"
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
set termwinsize=12x0
set splitbelow
let NERDTreeWinSize=20
set noswapfile
set nobackup
set noundofile

colorscheme molokai

" [ って打ったら [] って入力されてしかも括弧の中にいる(以下同様)
imap [ []<left>
imap ( ()<left>
imap { {}<left>
imap < <><left>
inoremap " ""<left>
inoremap ' ''<left>
nmap <Esc><Esc> :nohlsearch<CR><Esc>
nmap <C-@> :call TermOpen()<CR>
nmap <C-p> :call TermOpen()<CR>
nmap <C-b> :NERDTree<CR>
