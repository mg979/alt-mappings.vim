This plugin does 2 things:

- generates codes to be able to map `meta keys` in terminal vim
- provides plugs for a wrapper of the run/record macros commands (`q` and `@`)

You can also toggle the `meta keys` at will with <kbd>\<F12></kbd>.

Plug|Default
-|-
\<Plug>ToggleAltBindings   |<kbd>\<F12></kbd>
\<Plug>RecordMacro     |unmapped
\<Plug>RunMacro        |unmapped

The wrapper works by disabling `meta keys` just before running/recording the
macro, and applying them back when finished.

User autocommands are issued when starting/finishing recording/running
a macro, so you can do:

    au User RecordStart call ...()
    au User RecordEnd   call ...()
    au User MacroStart  call ...()
    au User MacroStart  call ...()

