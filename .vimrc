"当前行
":highlight LineNr ctermfg=red
":highlight LineNr ctermbg=white
set cursorline
"不与VI兼容
set nocompatible
let &termencoding=&encoding
set showcmd "Show (partial) command in status line.
"编码支持
set fileencodings=ucs-bom,utf-8,gbk,latin1
"语法高亮
syntax enable
syntax on
set ch=2		" Make command line two lines high
"当前行高亮
setlocal cursorline
"配色风格
colorscheme desert
set showmatch
"set tabstop=4
"set softtabstop=4
"set shiftwidth=4
set ffs=dos,unix
"c 格式缩进文本暂时取消掉
"set cindent
set autoindent
set nu
if &term=="xterm"
	set t_Co=8
	set t_Sb=^[[4%dm
	set t_Sf=^[[3%dm
endif
filetype on
filetype plugin indent on
set history=400
if exists("&autoread")
	set autoread
end
set ffs=dos,unix,mac
set incsearch
set nobackup
set nowb

"Interface set
set guifont=Fixedsys:h10
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
set lines=35 columns=150
set ruler
"set nowrap
set autochdir
set is
set hls
set tabpagemax=20
"Some Color Settings

"Toggle Menu and Toolbar
set guioptions-=m
set guioptions-=T
map <silent> <F2> :if &guioptions =~# 'T' <Bar>
        \set guioptions-=T <Bar>
        \set guioptions-=m <bar>
    \else <Bar>
        \set guioptions+=T <Bar>
        \set guioptions+=m <Bar>
    \endif<CR>
winpos 10 10
" 快捷键自定义
map <C-s> :w<CR>
imap <C-s> <C-o>:w<CR>
map <silent> <F9> :TlistToggle<cr>
map <F3> "+yy
map <F4> gg"+yG
map <F5> :wq<CR>
map <F6> o<ESC>"+p
map gy gg"+yG
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
"删除行尾空白
au BufWritePre * sil %s/\s\+$//e
"删除文件尾空行
au BufWritePre * %s/^$\n\+\%$//ge

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

"括号自动补全
"-------------------------------------------------------------------------------
" autocomplete parenthesis, brackets and braces
"-------------------------------------------------------------------------------
inoremap ( ()<Left>
inoremap [ []<Left>
inoremap { {}<Left>
"
vnoremap ( s()<Esc>P
vnoremap [ s[]<Esc>P
vnoremap { s{}<Esc>P

"
"tab show number
set showtabline=1 " always show tabs in gvim, but not vim
" set up tab labels with tab number, buffer name, number of windows
function! GuiTabLabel()
  let label = ''
  let bufnrlist = tabpagebuflist(v:lnum)
  " Add '+' if one of the buffers in the tab page is modified
  for bufnr in bufnrlist
    if getbufvar(bufnr, "&modified")
      let label = '+'
      break
    endif
  endfor
  " Append the tab number
  let label .= v:lnum.': '
  " Append the buffer name
  let name = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
  if name == ''
    " give a name to no-name documents
    if &buftype=='quickfix'
      let name = '[Quickfix List]'
    else
      let name = '[No Name]'
    endif
  else
    " get only the file name
    let name = fnamemodify(name,":t")
  endif
  let label .= name
  " Append the number of windows in the tab page
  let wincount = tabpagewinnr(v:lnum, '$')
  return label . '  [' . wincount . ']'
endfunction
set guitablabel=%{GuiTabLabel()}
" set up tab tooltips with every buffer name
function! GuiTabToolTip()
  let tip = ''
  let bufnrlist = tabpagebuflist(v:lnum)
  for bufnr in bufnrlist
    " separate buffer entries
    if tip!=''
      let tip .= " \n "
    endif
    " Add name of buffer
    let name=bufname(bufnr)
    if name == ''
      " give a name to no name documents
      if getbufvar(bufnr,'&buftype')=='quickfix'
        let name = '[Quickfix List]'
      else
        let name = '[No Name]'
      endif
    endif
    let tip.=name
    " add modified/modifiable flags
    if getbufvar(bufnr, "&modified")
      let tip .= ' [+]'
    endif
    if getbufvar(bufnr, "&modifiable")==0
      let tip .= ' [-]'
    endif
  endfor
  return tip
endfunction
set guitabtooltip=%{GuiTabToolTip()}


command Getuu %s/<a href="\(.*\)" target.*c3.*\(2016.*点\).*$/\2\t\1/g | g/^\s*$/d

