" Recover form accidental Ctrl-U
" http://vim.wikia.com/wiki/Recover_from_accidental_Ctrl-U
inoremap <c-u> <c-g>u<c-u>
inoremap <c-w> <c-g>u<c-w>

inoremap <C-e> <END>
inoremap <C-a> <HOME>
cnoremap <C-e> <END>
cnoremap <C-a> <HOME>
nnoremap <leader>ww :w!<cr>
nnoremap <C-z> :shell<cr>

nn <c-n> :bn<cr>
nn <c-h> :bp<cr>
nmap <m-j> <c-w>j
nmap <m-k> <c-w>k
nmap <m-h> <c-w>h
nmap <m-l> <c-w>l

map <F3> :cp<cr>
map <F4> :cn<cr>

inoremap <leader>1 ()<esc>i
inoremap <leader>2 []<esc>i
inoremap <leader>3 {}<esc>i
inoremap <leader>4 {<esc>o}<esc>O
inoremap <leader>5 <><esc>i
inoremap <leader>q ''<esc>i
inoremap <leader>w ""<esc>i
