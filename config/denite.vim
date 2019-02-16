" denite configs
if dein#tap('denite.nvim')
	call denite#custom#map(
    \ 'insert',
    \ '<DOWN>',
    \ '<denite:move_to_next_line>',
    \ 'noremap'
    \)
	call denite#custom#map(
    \ 'insert',
    \ '<UP>',
    \ '<denite:move_to_previous_line>',
    \ 'noremap'
    \)

  " Code borrowed from https://gist.github.com/dlants/8d7fadfb691b511f1376ba437a9aaea9
  " denite file search (c-p uses gitignore, c-o looks at everything)
  map <leader>f :DeniteProjectDir -buffer-name=git -direction=top file_rec/git<CR>
  "map <C-O> :DeniteProjectDir -buffer-name=files -direction=top file_rec<CR>

  " -u flag to unrestrict (see ag docs)
  call denite#custom#var('file_rec', 'command',
  \ ['ag', '--follow', '--nocolor', '--nogroup', '-u', '-g', ''])

  call denite#custom#alias('source', 'file_rec/git', 'file_rec')
  call denite#custom#var('file_rec/git', 'command',
  \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

  " denite content search
  map <leader>g :DeniteProjectDir -buffer-name=grep -default-action=quickfix grep:::!<CR>

  call denite#custom#source(
  \ 'grep', 'matchers', ['matcher_regexp'])

  " use ag for content search
  call denite#custom#var('grep', 'command', ['ag'])
  call denite#custom#var('grep', 'default_opts',
      \ ['-i', '--vimgrep'])
  call denite#custom#var('grep', 'recursive_opts', [])
  call denite#custom#var('grep', 'pattern_opt', [])
  call denite#custom#var('grep', 'separator', ['--'])
  call denite#custom#var('grep', 'final_opts', [])
endif
