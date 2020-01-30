
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Alt mappings for terminal vim, also disable mappings when executing macros
" A wrapper for the 'record/run macro' commands is provided, so that it will
" disable alt mappings while recording/running, and re-enable them thereafter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:loaded_alt_mappings = 1

" create aliases for C-Fn keys
if has('nvim')
  nmap <F25> <C-F1>
  nmap <F26> <C-F2>
  nmap <F27> <C-F3>
  nmap <F28> <C-F4>
  nmap <F29> <C-F5>
  nmap <F30> <C-F6>
  nmap <F31> <C-F7>
  nmap <F32> <C-F8>
  nmap <F33> <C-F9>
  nmap <F34> <C-F10>
  nmap <F35> <C-F11>
  nmap <F36> <C-F12>
endif

" no need for alt mappings in neovim/gui
if has('nvim') || has('gui_running')
  finish
endif

nnoremap <silent> <Plug>ToggleAltBindings :<c-u>call altmaps#toggle()<cr>
nnoremap <silent> <Plug>RecordMacro       :<c-u>call altmaps#record_macro()<cr>
nnoremap <silent> <Plug>RunMacro          :<c-u>call altmaps#run_macro(v:count1)<CR>


if get(g:, 'alt_macro_mappings', 1)
  if empty(maparg('q', 'n')) && !hasmapto('<Plug>RecordMacro')
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
