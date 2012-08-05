" detect os
" return value may be Linux/Mac/Windows
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

" quick functions for judge current system
function! IsWindows()   
    if exists("g:is_windows") | return g:is_windows | endif
    if DetectOS() == "Windows"
        let g:is_windows = 1 | else | let g:is_windows = 0 | endif
    return g:is_windows
endfunction

function! IsLinux()
    if exists("g:is_linux") | return g:is_linux | endif
    if DetectOS() == "Linux"
        let g:is_linux = 1 | else | let g:is_linux = 0 | endif
    return g:is_linux
endfunction

function! IsMac()
    if exists("g:is_mac") | return g:is_mac | endif
    if DetectOS() == "Linux"
        let g:is_mac = 1 | else | let g:is_mac = 0 | endif
    return g:is_mac
endfunction

function! IsGui()
    if has("gui_running") | return 1 | else | return 0 | endif
endfunction

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
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

" get current dir
function! CurDir()
    let curdir = substitute(getcwd(), $HOME, "~", "g")
    return curdir
endfunction
