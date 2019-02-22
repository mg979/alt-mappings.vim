"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

fun! altmaps#record_macro(...)
  if exists('g:recording_macro')
    if exists('*MacroAfter') | call MacroAfter() | endif
    unlet g:recording_macro
    execute "normal! q"
    execute "let @".s:macro_key." = @".s:macro_key."[:-2]"
    call altmaps#enable()
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
    if s:abort() || s:wrong() | return | endif
    call altmaps#disable()
    if exists('*MacroBefore') | call MacroBefore() | endif
    let g:recording_macro = 1
    execute "normal! q" . s:macro_key
  endif
endfun

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

fun! altmaps#run_macro(count)
  echohl Label | echo "Register?" | echohl None
  let s:macro_key = nr2char(getchar())
  if s:symbol() || s:abort() || s:wrong() | return | endif
  if exists('*MacroBefore') | call MacroBefore() | endif
  call altmaps#disable()
  execute "normal! ".(a:count>0? a:count."@".s:macro_key : "@@")
  if exists('*MacroAfter') | call MacroAfter() | endif
  call altmaps#enable()
endfun

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

fun! s:symbol()
  if index([':', '=', '/', '.'], s:macro_key) >= 0
    call feedkeys("@".s:macro_key, 'n')
    return 1
  endif
endfun

"------------------------------------------------------------------------------

fun! s:abort()
  if s:macro_key == "\<esc>"
    echohl WarningMsg | echon "\tCanceled." | echohl None
    return 1
  endif
endfun

"------------------------------------------------------------------------------

fun! s:wrong()
  let K = char2nr(s:macro_key)
  if !( K >= 65 && K<= 122 || K >= 48 && K <= 57 ) && K != 64
    echohl WarningMsg | echon "\tWrong character." | echohl None
    return 1
  endif
endfun

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

fun! altmaps#toggle()
  if !g:alt_keys_enabled
    if exists('*MacroAfter') | call MacroAfter() | endif
    call altmaps#enable()
    redraw!
    echo "Alt bindings enabled"
  else
    call altmaps#disable()
    if exists('*MacroBefore') | call MacroBefore() | endif
    redraw!
    echo "Alt bindings disabled"
  endif
endfun

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

fun! altmaps#enable()

  if g:alt_keys_enabled || has('nvim') || has('gui_running')
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

  "nmap [1;3P  <Plug>(M-F1)
  "nmap [1;3Q  <Plug>(M-F2)
  "nmap [1;3R  <Plug>(M-F3)
  "nmap [1;3S  <Plug>(M-F4)
  "map [15;3~ <Plug>(M-F5)
  "map [17;3~ <Plug>(M-F6)
  "map [18;3~ <Plug>(M-F7)
  "map [19;3~ <Plug>(M-F8)
  "map [20;3~ <Plug>(M-F9)
  "map [21;3~ <Plug>(M-F10)
  "map [23;3~ <Plug>(M-F11)
  "map [24;3~ <Plug>(M-F12)

  "map [1;3B <Plug>(M-up)
  "map [1;3A <Plug>(M-down)
  "map [1;3D <Plug>(M-left)
  "map [1;3C <Plug>(M-right)

  "map [1;7A <Plug>(M-C-up)
  "map [1;7B <Plug>(M-C-down)
  "map [1;7D <Plug>(M-C-left)
  "map [1;7C <Plug>(M-C-right)

  "map [1;7A <Plug>(M-C-up)
  "map [1;7B <Plug>(M-C-down)
  "map [1;7D <Plug>(M-C-left)
  "map [1;7C <Plug>(M-C-right)
endfun

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

fun! altmaps#disable()


  if !g:alt_keys_enabled || has('nvim') || has('gui_running')
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

  "nunmap [1;3P
  "nunmap [1;3Q
  "nunmap [1;3R
  "nunmap [1;3S
  "unmap [15;3~
  "unmap [17;3~
  "unmap [18;3~
  "unmap [19;3~
  "unmap [20;3~
  "unmap [21;3~
  "unmap [23;3~
  "unmap [24;3~

  "unmap [1;3B
  "unmap [1;3A
  "unmap [1;3D
  "unmap [1;3C

  "unmap [1;7A
  "unmap [1;7B
  "unmap [1;7D
  "unmap [1;7C

  "unmap [1;7A
  "unmap [1;7B
  "unmap [1;7D
  "unmap [1;7C

endfun
