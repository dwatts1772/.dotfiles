set makeprg=make

" clang settings
let os = substitute(system('uname'), "\n", "", "")
if os == "Linux"
    let g:deoplete#sources#clang#libclang_path = "/usr/lib/libclang.so"
    let g:deoplete#sources#clang#clang_header = "/usr/lib/clang"
elseif os == "Darwin"
    let g:deoplete#sources#clang#libclang_path = "/usr/local/Cellar/llvm/3.9.0/lib/libclang.dylib"
    let g:deoplete#sources#clang#clang_header = "/usr/local/opt/llvm/lib/clang"
endif
