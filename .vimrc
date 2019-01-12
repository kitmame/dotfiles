" flag
let s:use_dein = 1

" vi compatibility
if !&compatible
  set nocompatible
endif

" Prepare .vim dir {{{
let s:vimdir = $HOME . '/.vim'
if has('vim_starting')
  if ! isdirectory(s:vimdir)
    call system('mkdir ' . s:vimdir)
  endif
endif
" }}}

" check/prepare dein environment {{{
let s:dein_enabled  = 0
if v:version > 704 && s:use_dein && !filereadable(expand('~/.vim_no_dein'))
  let s:git = system('which git')
  if strlen(s:git) != 0
    " Set dein paths
    let s:dein_dir = s:vimdir . '/dein'
    let s:git_server = 'github.com'
    let s:dein_repo_name = 'Shougo/dein.vim'
    let s:dein_repo = 'https://' . s:git_server . '/' . s:dein_repo_name
    let s:dein_github = s:dein_dir . '/repos/' . s:git_server
    let s:dein_repo_dir = s:dein_github . '/' . s:dein_repo_name

    " Check dein has been installed or not.
    if !isdirectory(s:dein_repo_dir)
      let s:is_clone = confirm('Prepare dein?', 'Yes\nNo', 2)
      if s:is_clone == 1
        let s:dein_enabled = 1
        echo 'dein is not installed, install now '
        echo 'git clone ' . s:dein_repo . ' ' . s:dein_repo_dir
        call system('git clone ' . s:dein_repo . ' ' . s:dein_repo_dir)
        if v:version == 704
          call system('cd ' . s:dein_repo_dir . ' && git checkout -b 1.5 1.5' )
        endif
      endif
    else
      let s:dein_enabled = 1
    endif
  endif
endif
" }}} check/prepare dein environment

" Begin plugin part {{{
if s:dein_enabled
  let &runtimepath = &runtimepath . ',' . s:dein_repo_dir
  let g:dein#install_process_timeout =  600

  " Check cache
  if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    " dein
    " Do not manage dein at Vim 7.4, as it is not HEAD
    if v:version != 704
      call dein#add('Shougo/dein.vim')
    endif

    call dein#add('tpope/vim-surround')
    call dein#add('kana/vim-submode')

    call dein#add('nanotech/jellybeans.vim')
    call dein#add('altercation/vim-colors-solarized')
    call dein#add('w0ng/vim-hybrid')

    call dein#end()

    call dein#save_state()
  endif

  " Installation check.
  if dein#check_install()
    call dein#install()
  endif
endif
" }}}





  " begin plugin part
"  call dein#begin(s:dein_dir)
"
"  " Check cache
"  if dein#load_cache()
"
"    call dein#add('Shougo/dein.vim')
"
"    call dein#add('tpope/vim-surround')
"    call dein#add('kana/vim-submode')
"
"    call dein#add('nanotech/jellybeans.vim')
"    call dein#add('altercation/vim-colors-solarized')
"    call dein#add('w0ng/vim-hybrid')
"
"    call dein#save_cache()
"  endif
"
"  call dein#end()
"
"  " Installation check.
"  if dein#check_install()
"    call dein#install()
"  endif
"endif

set encoding=utf-8		" character encoding used in Vim internal
scriptencoding utf-8	" character encoding used in .vimrc


"" -------------
"" 基本
"" -------------
set autochdir       " Vimのカレントディレクトリを開いたファイルに合わせて自動的に切り替える

filetype on         " ファイル形式検出を有効化
filetype plugin on  " ファイル形式別プラグインのロードを有効化
filetype indent on  " ファイル形式別インデントのロードを有効化


"" -------------
"" 編集
"" -------------
set fileencoding=utf-8  " ファイルの保存に使われる文字コード
set fileencodings=iso-2022-jp,cp932,sjis,euc-jp     " 文字コードの自動判別候補（先頭から順に試される）
set fileformat=unix     " ファイルの保存に使われる改行コード
set fileformats=unix,dos,mac    " 改行コードの自動判別候補（先頭から順に試される）

set formatoptions=q " 'textwidth'で自動的に改行しないようにする
set backspace=indent,eol,start  " 挿入モードでのバックスペース押下時の動作を指定
" indent:       オートインデントの空白文字を backspace キーで削除できる.
" eol:          行の先頭で backspace キー押すと、上の行と連結できる.
" start:        最初から行にある文字(入力したばかりの文字以外)も削除できる.
set clipboard=autoselect        " ヤンクをクリップボードに反映
" unnamed:      ヤンク時レジスター指定しなかったら "* が選ばれる
" autoselect:   VisualMode 時にも unnamed と同じ動きをさせる
set showmatch       " 閉じ括弧が入力された時、対応する括弧を表示する
set matchtime=5     " 対応する括弧の始めを表示する時間(1/10s単位)

set expandtab       " <TAB>をスペースに置き換える
set tabstop=2       " <TAB>を画面上の見た目で何文字分に展開するか
set shiftwidth=2    " << や >> で挿入/削除されるインデント幅を、画面上の見た目で何文字分にするか
set softtabstop=0   " TABキーを押した時に挿入される空白の数。0だと'tabstop'と同値と扱われる
set autoindent      " 改行した時、前の行のインデントを継続する
"set smartindent     " 改行した時、前の行の末尾に合わせて次の行のインデントを増減する


"" -------------
"" 表示
"" -------------
set nonumber        " 行番号を表示しない
set cursorline      " 現在行をハイライト
set list            " 不可視な文字を表示する
set listchars=tab:>.,nbsp:%,precedes:<,extends:>,trail:-,eol:$  " 'list'の設定

set laststatus=2    " ステータスラインを常に表示する
"set statusline=%n\:%f%m%r\ %{(&fenc!=''?&fenc:&enc).'('.&ff.')'}%y%=0x%B\ %l/%L,%c(%p%%) " ステータスラインの表示内容を指定
set statusline=%m%r%n\:%<%f\ %{(&fenc!=''?&fenc:&enc).'('.&ff.')'}%y\ %=0x%B\ ln:%l/%L\ col:%c\ %p%%\ " ステータスラインの表示内容を指定
set showcmd         " 入力中のコマンドをステータスに表示する
set wildmenu        " コマンドライン補完するときに、補完候補を表示する


"" -------------
"" 移動
"" -------------
set scrolloff=3     " 指定した行数分の余裕を持たせてスクロールする


"" -------------
"" 検索
"" -------------
set ignorecase      " 検索パターンの大文字と小文字を区別しない
set smartcase       " 検索パターンに大文字が含まれたら、大文字と小文字を区別する
" 'ignorecase' と 'smartcase' を両方有効にすると、
" 小文字のみだと、大文字と小文字を区別なく検索し、
" 大文字が入ると 'ignorecase' が無効になり、大文字と小文字を区別して検索する
set hlsearch        " 検索結果をハイライトする
set incsearch       " インクリメンタルサーチを使う
set wrapscan        " 最後まで検索したら先頭に戻る


"" -------------
"" バックアップ
"" -------------
set backup
set swapfile
set undofile
if has('unix')
	set backupdir=~/.vim/backup
	set directory=~/.vim/swap
	set undodir=~/.vim/undo
"elseif has('mac')
"	set backupdir=~/Documents/.vim/backup
"	set directory=~/Documents/.vim/swap
elseif has('win64') || has('win32')
	set backupdir=$VIM/auto/backup
	set directory=$VIM/auto/swap
	set undodir=$VIM/auto/undo
endif


if has('win64') || has('win32')
    imap <F13> <Nop>
    imap <F14> <Nop>
endif


"" -------------------
"" NeoBundle settings
"" -------------------
"set nocompatible
"filetype plugin indent off
"if has('vim_starting')
"	set runtimepath+=~/.vim/bundle/neobundle.vim/
"	"call neobundle#rc(expand('~/.vim/bundle'))
"	call neobundle#begin(expand('~/.vim/bundle/'))
"	NeoBundleFetch 'Shougo/neobundle.vim'
"	call neobundle#end()
"endif
"NeoBundleFetch 'Shougo/neobundle.vim'	" Let NeoBundle manage NeoBundle
"
"" plugins
"NeoBundle 'tpope/vim-surround'
"NeoBundle 'kana/vim-submode'
"NeoBundle 'nathanaelkane/vim-indent-guides'
"NeoBundle 'bronson/vim-trailing-whitespace'
"
"" color schemes
"NeoBundle 'nanotech/jellybeans.vim'
"NeoBundle 'altercation/vim-colors-solarized'
"NeoBundle 'w0ng/vim-hybrid'

filetype plugin indent on


"" -------------------
"" Plugin settings
"" -------------------
" ----- vim-submode -----
" If this value is true, timeout on submodes is enabled.
let g:submode_timeout = 1
" The time in milliseconds that is waiting for typing keys in a submode.
let g:submode_timeoutlen = 3000
" ----- matchit -----
" % で対応するタグとかにもジャンプできる
source $VIMRUNTIME/macros/matchit.vim


" ウィンドウサイズ変更のキーバインドを簡易化
call submode#enter_with('resize_window', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('resize_window', 'n', '', '<C-w><', '<C-w><')
call submode#enter_with('resize_window', 'n', '', '<C-w>+', '<C-w>+')
call submode#enter_with('resize_window', 'n', '', '<C-w>-', '<C-w>-')
call submode#map('resize_window', 'n', '', '>', '<C-w>>')
call submode#map('resize_window', 'n', '', '<', '<C-w><')
call submode#map('resize_window', 'n', '', '+', '<C-w>+')
call submode#map('resize_window', 'n', '', '-', '<C-w>-')


syntax enable
syntax on
colorscheme jellybeans

