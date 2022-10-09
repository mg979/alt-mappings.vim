"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

fun! altmaps#record_macro()
  "Disable alt mappings while recording, re-enable them when finished {{{1
  if exists('g:recording_macro')
    silent doautocmd <nomodeline> User RecordEnd
    unlet g:recording_macro
    normal! q
    execute "let @".s:macro_key." = @".s:macro_key."[:-2]"
    call altmaps#enable()
  else
    try
      let s:macro_key = nr2char(getchar())
      if s:cmdwin()
        return feedkeys('q'.s:macro_key, 'n')
      elseif s:valid()
        call altmaps#disable()
        silent doautocmd <nomodeline> User RecordStart
        let g:recording_macro = 1
      endif
      execute "normal! q" . s:macro_key
    catch
      if exists('g:recording_macro')
        silent doautocmd <nomodeline> User RecordEnd
        unlet g:recording_macro
      endif
    endtry
  endif
endfun "}}}

fun! altmaps#run_macro(count)
  "Disable alt mappings while running macro, re-enable them when finished {{{1
  let key = nr2char(getchar())
  let n = a:count > 1 ? a:count : ''

  silent doautocmd <nomodeline> User MacroStart
  call altmaps#disable()

  if key == '='
    call feedkeys(n . '@=', 'n')
  else
    execute "normal! ". n ."@". key
    silent doautocmd <nomodeline> User MacroEnd
  endif

  call altmaps#enable()
endfun "}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

fun! s:cmdwin()
  "q: q? q/{{{1
  return index(split(':/?', '\zs'), s:macro_key) >= 0
endfun "}}}

fun! s:valid()
  "Valid register keys: A-Z, a-z, 0-9, unnamed {{{1
  let K = char2nr(s:macro_key)
  return  ( K >= 65 && K <= 90  ) ||
        \ ( K >= 97 && K <= 122 ) ||
        \ ( K >= 48 && K <= 57  ) ||
        \ K == 34
endfun "}}}

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

fun! altmaps#toggle()
  "<F12> by default toggles alt mappings {{{1
  if !g:alt_keys_enabled
    call altmaps#enable()
    redraw!
    echo "Alt bindings enabled"
  else
    call altmaps#disable()
    redraw!
    echo "Alt bindings disabled"
  endif
endfun "}}}

fun! altmaps#enable()
  "Enable meta mappings {{{1

  if has('nvim') || has('gui_running') || g:alt_keys_enabled
    return
  endif

  let g:alt_keys_enabled = 1

  set <M-a>=a
  set <M-b>=b
  set <M-c>=c
  set <M-d>=d
  set <M-e>=e
  set <M-f>=f
  set <M-g>=g
  set <M-h>=h
  set <M-i>=i
  set <M-j>=j
  set <M-k>=k
  set <M-l>=l
  set <M-m>=m
  set <M-n>=n
  set <M-o>=o
  set <M-p>=p
  set <M-q>=q
  set <M-r>=r
  set <M-s>=s
  set <M-t>=t
  set <M-u>=u
  set <M-v>=v
  set <M-w>=w
  set <M-y>=y
  set <M-x>=x
  set <M-z>=z

  set <M-A>=A
  set <M-B>=B
  set <M-C>=C
  set <M-D>=D
  set <M-E>=E
  set <M-F>=F
  set <M-G>=G
  set <M-H>=H
  set <M-J>=J
  set <M-K>=K
  set <M-L>=L
  set <M-M>=M
  set <M-N>=N
  set <M-P>=P
  set <M-Q>=Q
  set <M-R>=R
  set <M-S>=S
  set <M-T>=T
  set <M-U>=U
  set <M-V>=V
  set <M-W>=W
  set <M-Y>=Y
  set <M-X>=X
  set <M-Z>=Z

  set <M-0>=0
  set <M-1>=1
  set <M-2>=2
  set <M-3>=3
  set <M-4>=4
  set <M-5>=5
  set <M-6>=6
  set <M-7>=7
  set <M-8>=8
  set <M-9>=9

  set <M-/>=/
  set <M-=>==
  set <M-,>=,
  set <M-.>=.
  set <M-_>=_
  set <M-:>=:
  set <M-;>=;
  set <M-'>='
  set <M-->=-
  set <M-+>=+
  set <M-\>=\

  set <M-`>=`
  set <M-*>=*
  set <M-{>={
  set <M-}>=}
  set <M-?>=?
  set <M-^>=^
  set <M-~>=~
  set <M-!>=!
  set <M-$>=$
  set <M-%>=%
  set <M-&>=&
  set <M-(>=(
  set <M-)>=)
  set <M-<>=<

  set <S-Del>=[3;2~
endfun "}}}

fun! altmaps#disable()
  "Disable meta mappings {{{1

  if has('nvim') || has('gui_running') || !g:alt_keys_enabled
    return
  endif

  let g:alt_keys_enabled = 0

  set <M-a>=<nop>
  set <M-b>=<nop>
  set <M-c>=<nop>
  set <M-d>=<nop>
  set <M-e>=<nop>
  set <M-f>=<nop>
  set <M-g>=<nop>
  set <M-h>=<nop>
  set <M-i>=<nop>
  set <M-j>=<nop>
  set <M-k>=<nop>
  set <M-l>=<nop>
  set <M-m>=<nop>
  set <M-n>=<nop>
  set <M-o>=<nop>
  set <M-p>=<nop>
  set <M-q>=<nop>
  set <M-r>=<nop>
  set <M-s>=<nop>
  set <M-t>=<nop>
  set <M-u>=<nop>
  set <M-v>=<nop>
  set <M-w>=<nop>
  set <M-y>=<nop>
  set <M-x>=<nop>
  set <M-z>=<nop>

  set <M-A>=<nop>
  set <M-B>=<nop>
  set <M-C>=<nop>
  set <M-D>=<nop>
  set <M-E>=<nop>
  set <M-F>=<nop>
  set <M-G>=<nop>
  set <M-H>=<nop>
  set <M-J>=<nop>
  set <M-K>=<nop>
  set <M-L>=<nop>
  set <M-M>=<nop>
  set <M-N>=<nop>
  set <M-P>=<nop>
  set <M-Q>=<nop>
  set <M-R>=<nop>
  set <M-S>=<nop>
  set <M-T>=<nop>
  set <M-U>=<nop>
  set <M-V>=<nop>
  set <M-W>=<nop>
  set <M-Y>=<nop>
  set <M-X>=<nop>
  set <M-Z>=<nop>

  set <M-0>=<Nop>
  set <M-1>=<Nop>
  set <M-2>=<Nop>
  set <M-3>=<Nop>
  set <M-4>=<Nop>
  set <M-5>=<Nop>
  set <M-6>=<Nop>
  set <M-7>=<Nop>
  set <M-8>=<Nop>
  set <M-9>=<Nop>

  set <M-/>=<Nop>
  set <M-=>=<Nop>
  set <M-,>=<Nop>
  set <M-.>=<Nop>
  set <M-_>=<Nop>
  set <M-:>=<Nop>
  set <M-;>=<Nop>
  set <M-'>=<Nop>
  set <M-->=<Nop>
  set <M-+>=<Nop>
  set <M-\>=<Nop>

  set <M-`>=<Nop>
  set <M-*>=<Nop>
  set <M-{>=<Nop>
  set <M-}>=<Nop>
  set <M-?>=<Nop>
  set <M-^>=<Nop>
  set <M-~>=<Nop>
  set <M-!>=<Nop>
  set <M-$>=<Nop>
  set <M-%>=<Nop>
  set <M-&>=<Nop>
  set <M-(>=<Nop>
  set <M-)>=<Nop>
  set <M-<>=<Nop>

  set <S-Del>=<Nop>
endfun "}}}

" vim: set sw=2 ts=2 sts=2 et fdm=marker
