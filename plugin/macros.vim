
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

if empty(mapcheck("q", 'n')) && !hasmapto('<Plug>SilentMacro')
  nmap q <Plug>SilentMacro
endif

if empty(mapcheck("@", 'n')) && !hasmapto('<Plug>RunMacro')
  nmap @ <Plug>RunMacro
endif

map <silent> <Plug>ToggleAltBindings :<c-u>call altmaps#toggle()<cr>
if empty(mapcheck("\<F12>", 'n')) && !hasmapto('<Plug>ToggleAltBindings')
  nmap <silent> <F12> <Plug>ToggleAltBindings
endif


" enable alt bindings on load
let g:loaded_alt_mappings = 1
let g:alt_keys_enabled = 0
call altmaps#enable()

