" Code borrowed from SpaceVim:
" https://github.com/SpaceVim/SpaceVim/blob/master/autoload/SpaceVim/api/system.vim

let s:system = {}

let s:system['isWindows'] = has('win16') || has('win32') || has('win64')
let s:system['isLinux'] = has('unix') && !has('macunix') && !has('win32unix')
let s:system['isOSX'] = has('macunix')

function! s:name() abort
  if s:system.isLinux
    return 'Linux'
  elseif s:system.isWindows
    return 'Windows'
  else
    return 'OSX'
  endif
endfunction

let s:system['name'] = s:name()

function! s:isDarwin() abort
  if exists('s:is_darwin')
    return s:is_darwin
  endif

  if has('macunix')
    let s:is_darwin = 1
    return s:is_darwin
  endif

  if ! has('unix')
    let s:is_darwin = 0
    return s:is_darwin
  endif

  if system('uname -s') ==# "Darwin\n"
    let s:is_darwin = 1
  else
    let s:is_darwin = 0
  endif

  return s:is_darwin
endfunction

let s:system['isDarwin'] = s:isDarwin()

function! s:fileformat() abort
  let fileformat = ''
  if &fileformat ==? 'dos'
    let fileformat = ''
  elseif &fileformat ==? 'unix'
    if s:isDarwin()
      let fileformat = ''
    else
      let fileformat = ''
    endif
  elseif &fileformat ==? 'mac'
    let fileformat = ''
  endif

  return fileformat
endfunction

let s:system['fileformat'] = s:fileformat()

if has('win16') || has('win32') || has('win64')
  let s:system['Psep'] = ';'
  let s:system['Fsep'] = '\'
else
  let s:system['Psep'] = ':'
  let s:system['Fsep'] = '/'
endif

" when using macOS, use homebrew installed version of bash for shell
function! s:shell() abort
  if executable('/usr/local/bin/bash')
    return '/usr/local/bin/bash'
  else
    return '/bin/bash'
  endif
endfunction

let s:system['shell'] = s:shell()

let g:system = deepcopy(s:system)

" g:system:
"   isWindows: bool
"   isLinux: bool
"   isOSX: bool
"   isDarwin: bool
"   name: string, Linux/Windows/OSX
"   shell: /usr/local/bin/bash or /bin/bash
"   fileformat: ?
"   Psep: string, ; or \
"   Fsep: string, : or /
