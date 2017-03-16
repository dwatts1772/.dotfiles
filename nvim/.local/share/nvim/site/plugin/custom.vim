"          [guifg, guibg, ctermfg, ctermbg, opts]

" Normal
let s:N1 = ['', '', {{background.base256()}}, {{accent.base8()}}]
let s:N2 = ['', '', {{accent.base8()}}, 'None']
let s:N3 = ['', '', {{foreground.base256()}}, 'None']

" Insert
let s:I1 = ['', '', {{background.base256()}}, {{airInsert.base256()}}]
let s:I2 = ['', '', {{airInsert.base256()}}, 'None']
let s:I3 = ['', '', {{foreground.base256()}}, 'None']

" Visual
let s:V1 = ['', '', {{background.base256()}}, {{airVisual.base256()}}]
let s:V2 = ['', '', {{airVisual.base256()}}, 'None']
let s:V3 = ['', '', {{foreground.base256()}}, 'None']

" Replace
let s:R1 = ['', '', {{background.base256()}}, {{airReplace.base256()}}]
let s:R2 = ['', '', {{airReplace.base256()}}, 'None']
let s:R3 = ['', '', {{foreground.base256()}}, 'None']

" Inactive
let s:IA1 = ['', '', {{background.base256()}}, 247]
let s:IA2 = ['', '', 247, 'None']
let s:IA3 = ['', '', 247, 'None']

" ctrlp
let s:CP1 = ['', '', {{foreground.base256()}}, 'None']
let s:CP2 = ['', '', {{accent.base8()}}, 'None']
let s:CP3 = ['', '', {{background.base256()}}, {{accent.base8()}}]

" Tabs
let s:TS = ['', '', 232, {{accent.base8()}}]
let s:TU = ['', '', {{accent.base8()}}, 'None']
let s:TSM = ['', '', 232, {{urgent.base8()}}]
let s:TUM = ['', '', {{urgent.base8()}}, 'None'] " can't understand how it works
let s:TT = ['', '', 232, {{accent.base8()}}]


let g:airline#themes#custom#palette = {
    \'normal': airline#themes#generate_color_map(s:N1, s:N2, s:N3),
    \'insert': airline#themes#generate_color_map(s:I1, s:I2, s:I3),
    \'visual': airline#themes#generate_color_map(s:V1, s:V2, s:V3),
    \'replace': airline#themes#generate_color_map(s:R1, s:R2, s:R3),
    \'inactive': airline#themes#generate_color_map(s:IA1, s:IA2, s:IA3),
    \'ctrlp': airline#extensions#ctrlp#generate_color_map(s:CP1, s:CP2, s:CP3)
    \}

let g:airline#themes#custom#palette.accents = {
    \'red': ['#E57.base8()6D' , '' , 203 , '' , ''],
    \}

let g:airline#themes#custom#palette.tabline = {
    \'airline_tab': s:TU,
    \'airline_tabsel': s:TS,
    \'airline_tabmod': s:TSM,
    \'airline_tabmod_unsel': s:TUM,
    \'airline_tabtype': s:TT,
    \}

