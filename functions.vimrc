if !exists("g:vimrcroot")
  let g:vimrcroot = fnamemodify(resolve(expand('<sfile>:p')), ':h') . "/"
endif

" detect os
" return value may be Linux/Mac/Windows/Unknown
function! DetectOS()
  if exists("g:operating_system") | return g:operating_system | endif
  if (has("win32") || has("win64") || has("win32unix"))
    let g:operating_system = "Windows"
  elseif has("unix")
    let os = substitute(system('uname'), "\n", "", "")
    if os == "Darwin"
      let g:operating_system = "Mac"
    elseif os == "Linux"
      let g:operating_system = "Linux"
    else
      let g:operating_system = "Unknown"
    endif
  endif
  return g:operating_system
endfunction

function! IsWindows()
  return DetectOS() == "Windows"
endfunction

function! IsLinux()
  return DetectOS() == "Linux"
endfunction

function! IsMac()
  return DetectOS() == "Mac"
endfunction

function! IsGui()
  if has("gui_running") | return 1 | else | return 0 | endif
endfunction

function! IsRemote()
  if empty($SSH_CONNECTION) | return 0 | else | return 1 | endif
  " TODO check other remote method, rsh/telnet ...
endfunction

" Append the plugin name to g:pathogen_disabled, to prevent pathogen from loading the plugin
function! DisablePlugin(plugin)
  if !exists("g:pathogen_disabled")
    let g:pathogen_disabled = []
  endif
  let g:pathogen_disabled += [a:plugin]
endfunction

" Disable the function if a:condition is true
function! DisablePluginIf(plugin, condition, message)
  if a:condition
    if a:message | echomsg a:message | endif
    call DisablePlugin(a:plugin)
  endif
endfunction

" Check if a:plugin is installed and not in g:pathogen_disabled
function! IsPluginEnabled(plugin)
  if !exists("g:pathogen_disabled")
    let g:pathogen_disabled = []
  endif
  return finddir(a:plugin, expand(g:vimrcroot . "bundles/")) != "" && (index(g:pathogen_disabled, a:plugin) < 0)
endfunction

function! IsPathogenInstalled()
  return filereadable(g:vimrcroot . "bundles/pathogen/autoload/pathogen.vim")
endfunction

function! UpdateSubmodules()
  if executable("git")
    echo "updating submodules ..."
    execute "! cd " . g:vimrcroot . " && git submodule update --init"
    return 1
  else
    echo "executable 'git' not found in $PATH, not able to update submodules"
    return 0
  endif
endfunction

" with escalt.vim, there is no need to use this function any more
" http://lilydjwg.is-programmer.com/posts/23574.html
" http://lilydjwg.is-programmer.com/user_files/lilydjwg/File/escalt.vim
"function! MapAltKey(mode, combo, command)
"    if (IsGui())
"        execute a:mode . "map <m-" a:combo . "> " . a:command
"    else
"        execute a:mode . "map <esc>" . a:combo . " " . a:command
"    endif
"endfunction

" search word under cursor
function! VisualSearch(direction) range
  let l:saved_reg = @"
  execute "normal! vgvy"
  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")
  if a:direction == 'b'
    execute "normal ?" . l:pattern . "<cr>"
  else
    execute "normal /" . l:pattern . "<cr>"
  endif
  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

" don't close window when deleting buffer
command! Bclose call <SID>BufcloseCloseIt()

function! <SID>BufcloseCloseIt()
  let l:currentBufNum = bufnr("%")
  let l:alternateBufNum = bufnr("#")
  if buflisted(l:alternateBufNum) | buffer # | else | bnext | endif
  if bufnr("%") == l:currentBufNum | new | endif
  if buflisted(l:currentBufNum) | execute("bdelete! ".l:currentBufNum) | endif
endfunction

" get current dir
function! CurDir()
  return substitute(getcwd(), $HOME, "~", "g")
endfunction

" set tab width
function! SetTabWidth(width)
  setlocal expandtab
  let &shiftwidth = a:width
  let &tabstop = a:width
endfunction

function! Source(file)
  exec "silent! source " . g:vimrcroot . a:file
endfunction

function! SetSkeleton(suffix, filename)
  exec "autocmd BufNewFile *." . a:suffix . " TSkeletonSetup " . g:vimrcroot . "skeletons/" . a:filename
endfunction

function! ReadOrCreateFile(file)
  if !filereadable(a:file)
    let dirname = fnamemodify(a:file, ":h")
    if !isdirectory(dirname)
      call mkdir(dirname, "p")
    endif
    call system("touch " . a:file)
  endif
  return readfile(a:file)
endfunction

" warning with a message only once (across vim restart)
function! WarnOnce(message)
  let l:warnings_file = g:vimrcroot . "cache/warnings"
  if !exists("s:warnings")
    let s:warnings = ReadOrCreateFile(l:warnings_file)
  endif
  if index(s:warnings, a:message) >= 0
    return
  endif
  call add(s:warnings, a:message)
  call writefile([a:message], l:warnings_file, "a")
  echohl WarningMsg
  echomsg a:message
  echohl None
endfunction

function! NERDTreeQuit()
  redir => buffersoutput
  silent buffers
  redir END
"                     1BufNo  2Mods.     3File           4LineNo
  let pattern = '^\s*\(\d\+\)\(.....\) "\(.*\)"\s\+line \(\d\+\)$'
  let windowfound = 0

  for bline in split(buffersoutput, "\n")
    let m = matchlist(bline, pattern)

    if (len(m) > 0)
      if (m[2] =~ '..a..')
        let windowfound = 1
      endif
    endif
  endfor

  if (!windowfound)
    quitall
  endif
endfunction

let s:go_packages = [
      \ "honnef.co/go/tools/cmd/gosimple",
      \]
function! InstallGoBinaries()
  " install vim-go commands
  execute 'GoUpdateBinaries'

  " Install additional go tools
  let $GOBIN = g:go_bin_path
  for pkg in s:go_packages
    echo "Installing " . pkg . " to folder " . g:go_bin_path
    call system("go get " . pkg)
  endfor
endfunction
