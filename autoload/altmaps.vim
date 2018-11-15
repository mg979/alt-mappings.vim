"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

fun! altmaps#record_macro(...)
  if exists('g:recording_macro')
    if exists('*MacroAfter') | call MacroAfter() | endif
    unlet g:recording_macro
    execute "normal! q"
    execute "let @".s:macro_key." = @".s:macro_key."[:-2]"
    call altmaps#set(1, get(g:, 'alt_maps_mode', 0))
    if !a:0
      redraw!
      echohl Label | echo "Finished recording macro "
      echohl None  | echon s:macro_key
    endif
  else
    if !a:0
      redraw!
      echohl Label | echo "Macro register?" | echohl None
    endif
    let s:macro_key = nr2char(getchar())
    if s:cancel() | return | endif
    call altmaps#set(0, get(g:, 'alt_maps_mode', 0))
    if exists('*MacroBefore') | call MacroBefore() | endif
    let g:recording_macro = 1
    execute "normal! q" . s:macro_key
  endif
endfun

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

fun! s:cancel()
  if s:macro_key == "\<esc>"
    echohl WarningMsg | echon "\tCanceled." | echohl None
    return 1
  elseif index([':', '=', '/', '.'], s:macro_key) >= 0
    call feedkeys("@".s:macro_key, 'n')
    return 1
  endif
endfun

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

fun! altmaps#toggle()
  if !g:alt_keys_enabled
    if exists('*MacroAfter') | call MacroAfter() | endif
    call altmaps#set(1, g:alt_maps_mode)
    redraw!
    echo "Alt bindings enabled"
  else
    call altmaps#set(0, g:alt_maps_mode)
    if exists('*MacroBefore') | call MacroBefore() | endif
    redraw!
    echo "Alt bindings disabled"
  endif
endfun

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

fun! altmaps#run_macro(count)
  echohl Label | echo "Register?" | echohl None
  let s:macro_key = nr2char(getchar())
  if s:cancel() | return | endif
  if exists('*MacroBefore') | call MacroBefore() | endif
  call altmaps#set(0, g:alt_maps_mode)
  execute "normal! ".(a:count>0? a:count."@".s:macro_key : "@@")
  if exists('*MacroAfter') | call MacroAfter() | endif
  call altmaps#set(1, g:alt_maps_mode)
endfun

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

fun! s:metacode(enable, mode, key)
  if index(['O', 'I'], a:key) >= 0
    return
  elseif !a:enable
    exec "set <M-".a:key.">=<nop>"
  elseif a:mode == 0
    exec "set <M-".a:key.">=\e".a:key
  else
    exec "set <M-".a:key.">=\e]{0}".a:key."~"
  endif
endfun

fun! altmaps#set(enable, mode)
  if !exists('g:loaded_alt_mappings') | return | endif
  for i in range(10)
    call s:metacode(a:enable, a:mode, nr2char(char2nr('0') + i))
  endfor
  for i in range(26)
    call s:metacode(a:enable, a:mode, nr2char(char2nr('a') + i))
    call s:metacode(a:enable, a:mode, nr2char(char2nr('A') + i))
  endfor

  let chars = extend(split(",./;{}?:-_`'*^~!$%&()<", '\zs'),
        \a:mode? ['[', ']'] : [])

  for c in chars
    call s:metacode(a:enable, a:mode, c)
  endfor

  let g:alt_keys_enabled = a:enable
endfun

