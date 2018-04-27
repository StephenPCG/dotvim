" file type settings for vim

" {{{1 vim
augroup filetype_vim
  autocmd!
  autocmd FileType vim call SetTabWidth(2)
augroup END

" {{{1 nginx
augroup filetype_nginx
  autocmd!
  autocmd BufRead,BufNewFile /etc/nginx/* set ft=nginx
  autocmd FileType nginx call SetTabWidth(4)
augroup END

" {{{1 latex
let g:tex_flavor='latex'
augroup filetype_latex
  autocmd!
  autocmd FileType latex setlocal iskeyword+=:
augroup END

" {{{1 python
augroup filetype_python
  autocmd!
  autocmd FileType python call SetTabWidth(4)
augroup END

" {{{1 lua
augroup filetype_lua
  autocmd!
  autocmd FileType lua call SetTabWidth(4)
augroup END

" {{{1 sh
augroup filetype_sh
  autocmd!
  autocmd FileType sh call SetTabWidth(4)
augroup END

" {{{1 git commit
augroup filetype_gitcommit
  autocmd!
  autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])
augroup END

" {{{1 markdown
augroup filetype_markdown
  autocmd!
  autocmd BufNewFile,BufReadPost *.md set filetype=markdown
  autocmd FileType markdown call SetTabWidth(4)
  "autocmd FileType markdown setlocal foldmethod=syntax
augroup END

" {{{1 golang
augroup filetype_golang
  autocmd!
  autocmd FileType go setlocal noexpandtab
  autocmd FileType go setlocal tabstop=8
  autocmd FileType go setlocal shiftwidth=8
  "" Don't fold code, or it will fold on each save
  "autocmd FileType go setlocal foldmethod=syntax
  autocmd FileType go setlocal foldnestmax=0
augroup END

" {{{1 sql server
augroup filetype_sql_server
  autocmd!
  autocmd BufNewFile,BufRead *.mssql set filetype=sqlserver
  autocmd FileType sqlserver call SetTabWidth(4)
augroup END

" {{{1 web
augroup filetype_web
  autocmd!
  autocmd FileType html call SetTabWidth(2)
  autocmd FileType css call SetTabWidth(2)
  autocmd FileType javascript call SetTabWidth(4)
augroup END

" {{{1 yaml
augroup filetype_yaml
  autocmd!
  autocmd FileType yaml call SetTabWidth(2)
augroup END
