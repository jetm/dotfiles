" Disable markdown plugin. I need to learn how to use it
let g:polyglot_disabled = ['markdown']

"
" Misc
"

" Set Python X version to 3
" pythonx looks for python3, instead of python3/dyn
" (Arch Linux python version)
if has('python3') || has('python3/dyn')
  set pyx=3
endif
