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

nnoremap <c-n> :bn<cr>
nnoremap <c-h> :bp<cr>
nnoremap <m-j> <c-w>j
nnoremap <m-k> <c-w>k
nnoremap <m-h> <c-w>h
nnoremap <m-l> <c-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l

map <F3> :cp<cr>
map <F4> :cn<cr>

inoremap <leader>1 ()<esc>i
inoremap <leader>2 []<esc>i
inoremap <leader>3 {}<esc>i
inoremap <leader>4 {<esc>o}<esc>O
inoremap <leader>5 <><esc>i
inoremap <leader>q ''<esc>i
inoremap <leader>w ""<esc>i

if has('nvim')
  nnoremap <c-z> :terminal<cr>
  tnoremap <Esc> <C-\><C-n>
  tnoremap <A-h> <C-\><C-N><C-w>h
  tnoremap <A-j> <C-\><C-N><C-w>j
  tnoremap <A-k> <C-\><C-N><C-w>k
  tnoremap <A-l> <C-\><C-N><C-w>l
else
  nnoremap <c-z> :shell<cr>
endif
