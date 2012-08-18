"" key mapping stuffs

let mapleader = ";"
nmap <space> :
vmap <space> :

" quick edit .vimrc and source it automatically
nmap <silent> <leader>ee :tabedit $MYVIMRC<cr>
autocmd! bufwritepost *.vimrc source $MYVIMRC | call Pl#Load()

nmap <leader>ww :w!<cr>
nmap <C-Z> :shell<cr>
nmap <C-X> :VimShell<cr>

" navigate
map gf :tabnew <cfile><cr>
nn <c-n> :bn<cr>
nn <c-h> :bp<cr>
if (IsGui())
    nn <m-n> :tabnext<cr>
    nn <m-h> :tabprevious<cr>
    nn <m-d> :tabclose<cr>
    nn <m-t> :tabnew<cr>
    nn <m-f> :Texplore<cr>
else
    nn <esc>n :tabnext<cr>
    nn <esc>h :tabprevious<cr>
    nn <esc>d :tabclose<cr>
    nn <esc>t :tabnew<cr>
    nn <esc>f :Texplore<cr>
endif
" Bash(Emacs) key binding
imap <C-e> <END>
imap <C-a> <HOME>

" Auto completion
" <CR>: close popup and save indent.

"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
inoremap <expr><CR>  pumvisible() ? neocomplcache#close_popup() : "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
"inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-c>  neocomplcache#cancel_popup()
" f: filename, l: line, d: dictionary, ]: tag
"imap <C-]>             <C-X><C-]>
"imap <C-F>             <C-X><C-F>
"imap <C-D>             <C-X><C-D>
"imap <C-L>             <C-X><C-L> 

" quick fix
map <leader>cw :cw<cr>
map <F3> :cp<cr>
map <F4> :cn<cr>

" search
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" plugins
nmap <silent> T :TagbarToggle<cr>
nmap <leader>n :NERDTreeToggle<cr>
nmap <silent> F :BufExplorer<CR>

"  fuzzy finder
nmap <leader>ff <esc>:FufFile<cr>
nmap <leader>fd <esc>:FufDir<cr>
nmap <leader>fu <esc>:FufBuffer<cr>
nmap <leader>ft <esc>:FufTag<cr>
nmap <silent> <c-\> :FufTag! <c-r>=expand('<cword>')<cr><cr>

" cscope bindings 
if has("cscope")
    set csto=1
    set cst
    set nocsverb
    if filereadable("cscope.out")
        cs add cscope.out
    endif
    set csverb
    " s: C语言符号  g: 定义     d: 这个函数调用的函数 c: 调用这个函数的函数
    " t: 文本       e: egrep模式    f: 文件     i: include本文件的文件
    nmap <leader>ss :cs find s <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>sg :cs find g <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>sc :cs find c <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>st :cs find t <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>se :cs find e <C-R>=expand("<cword>")<CR><CR>
    nmap <leader>sf :cs find f <C-R>=expand("<cfile>")<CR><CR>
    nmap <leader>si :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
    nmap <leader>sd :cs find d <C-R>=expand("<cword>")<CR><CR>
endif
set cscopequickfix=s-,c-,d-,i-,t-,e-

" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" quick input
inoremap <leader>1 ()<esc>:let leavechar=")"<cr>i
inoremap <leader>2 []<esc>:let leavechar="]"<cr>i
inoremap <leader>3 {}<esc>:let leavechar="}"<cr>i
inoremap <leader>4 {<esc>o}<esc>:let leavechar="}"<cr>O
inoremap <leader>5 <><esc>:let leavechar=">"<cr>i
inoremap <leader>q ''<esc>:let leavechar="'"<cr>i
inoremap <leader>w ""<esc>:let leavechar='"'<cr>i

" vimshell
map <F2> :VimShellPop -toggle<CR>
