let g:neomake_javascript_lint_maker = {
    \ 'exe': 'jscs',
    \ 'args': ['--no-color', '--reporter inline'],
    \ 'errorformat': '%f: line %l\, col $c\, %m'
    \}
