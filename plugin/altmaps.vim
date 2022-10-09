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
if has('nvim') || has('gui_running') || v:version < 800
  finish
endif

nnoremap <silent> <Plug>ToggleAltBindings :<c-u>call altmaps#toggle()<cr>
nnoremap <silent> <Plug>RecordMacro       :<c-u>call altmaps#record_macro()<cr>
nnoremap <silent> <Plug>RunMacro          :<c-u>call altmaps#run_macro(v:count1)<CR>

command! -bar ToggleAltBindings call altmaps#toggle()

" enable alt bindings on load
let g:alt_keys_enabled = 0

augroup alt_mappings
    au!
    au User visual_multi_start call altmaps#disable()
    au User visual_multi_exit  call altmaps#enable()
    if exists('##TerminalOpen')
        au TerminalOpen * if &buftype == 'terminal' |
                    \ silent doautocmd <nomodeline> User TerminalEnter |
                    \ endif
    endif
    au VimEnter * call timer_start(50, { t -> altmaps#enable() })
    au BufEnter * if &buftype == 'terminal' |
                \ silent doautocmd <nomodeline> User TerminalEnter |
                \ endif
    au BufLeave * if &buftype == 'terminal' |
                \ silent doautocmd <nomodeline> User TerminalLeave |
                \ endif
    au BufEnter !/* silent doautocmd <nomodeline> User TerminalEnter
    au BufLeave !/* silent doautocmd <nomodeline> User TerminalLeave
augroup END
