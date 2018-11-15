
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Alt mappings for terminal vim, also disable mappings when executing macros
" A wrapper for the 'record macro' command is provided, so that it will
" disable alt mappings while recording/running, and re-enable them thereafter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <silent> <Plug>RecordMacro       :<c-u>call altmaps#record_macro()<cr>
map <silent> <Plug>SilentMacro       :<c-u>call altmaps#record_macro(1)<cr>
map <silent> <Plug>RunMacro          :<c-u>call altmaps#run_macro(v:count1)<CR>

" no need for alt mappings in neovim/gui
if has('nvim') || has('gui_running')
    finish
endif

if !hasmapto('<Plug>RecordMacro')
    nmap q <Plug>RecordMacro
endif

if !hasmapto('<Plug>SilentMacro')
    nmap qq <Plug>SilentMacroq
endif

if !hasmapto('<Plug>RunMacro')
    nmap @ <Plug>RunMacro
endif

map <silent> <Plug>ToggleAltBindings :<c-u>call altmaps#toggle()<cr>
if !hasmapto('<Plug>ToggleAltBindings')
    nmap <silent> <F12> <Plug>ToggleAltBindings
endif


" enable alt bindings on load
let g:loaded_alt_mappings = 1
let g:alt_maps_mode       = get(g:, 'alt_maps_mode', 0)
au VimEnter * call altmaps#set(1, g:alt_maps_mode)

