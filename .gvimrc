:scriptencoding utf-8	" .gvimrcのエンコーディング指定

set background=dark

" ツールバーを消す
if has('win64') || has('win32')
	set guioptions-=T
	set guioptions-=m
endif

" font settings
if has('win64') || has('win32')
  " Windows用
  set guifont=MeiryoKe_Console:h10:cSHIFTJIS
  "set guifont=Migu_1M:h10
  "set guifont=Ricty\ Diminished:h10:cSHIFTJIS
  "set guifont=Osaka−等幅:h11:cSHIFTJIS
  "set guifont=VL_ゴシック:h10:cSHIFTJIS
  "set guifont=MS_Gothic:h12:cSHIFTJIS
  "set guifont=MS_Mincho:h12:cSHIFTJIS
  set antialias
endif

" kaoriya gVim メニューの文字化け対策
if has('win64') || has('win32')
  source $VIMRUNTIME/delmenu.vim
  set langmenu=ja_jp.utf-8
  source $VIMRUNTIME/menu.vim
endif

"if has('gui_macvim')
"  autocmd GUIEnter * set transparency=10
"  autocmd FocusGained * set transparency=10
"  autocmd FocusLost * set transparency=40
"else
"  autocmd GUIEnter * set transparency=240
"  autocmd FocusGained * set transparency=240
"  autocmd FocusLost * set transparency=170
"endif

