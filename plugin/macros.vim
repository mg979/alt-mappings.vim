
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Alt mappings for terminal vim, also disable mappings when executing macros
" A wrapper for the 'record macro' command is provided, so that it will
" disable alt mappings while recording/running, and re-enable them thereafter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:loaded_alt_mappings = 1

" no need for alt mappings in neovim/gui
if has('nvim') || has('gui_running')
  finish
endif

nnoremap <silent> <Plug>ToggleAltBindings :<c-u>call altmaps#toggle()<cr>
nnoremap <silent> <Plug>RecordMacro       :<c-u>call altmaps#record_macro()<cr>
nnoremap <silent> <Plug>RunMacro          :<c-u>call altmaps#run_macro(v:count1)<CR>


if get(g:, 'alt_macro_mappings', 1)
  if empty(maparg('q', 'n')) && !hasmapto('<Plug>SilentMacro')
    nmap q <Plug>RecordMacro
  endif

  if empty(maparg('@', 'n')) && !hasmapto('<Plug>RunMacro')
    nmap @ <Plug>RunMacro
  endif
endif

if empty(mapcheck("\<F12>", 'n')) && !hasmapto('<Plug>ToggleAltBindings')
  nmap <silent> <F12> <Plug>ToggleAltBindings
endif

" enable alt bindings on load
let g:alt_keys_enabled = 0
call altmaps#enable()

au User visual_multi_start call altmaps#disable()
au User visual_multi_exit  call altmaps#enable()
