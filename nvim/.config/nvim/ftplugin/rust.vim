let os = substitute(system('uname'), "\n", "", "")

if os == "Linux"
    let g:deoplete#sources#rust#racer_binary = "/usr/bin/racer"
    let g:deoplete#sources#rust#rust_source_path = "/usr/src/rust/src"
elseif os == "Darwin"
    let g:deoplete#sources#rust#racer_binary = expand("~/.local/bin/racer")
    let g:deoplete#sources#rust#rust_source_path = expand("~/.local/src/rust/src")
endif

let g:rustfmt_autosave = 1
let g:neomake_rust_enabled_makers = []

autocmd BufWritePost *.rs Neomake! cargo

