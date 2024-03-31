" This is necessary for VimTeX to load properly. The "indent" is optional.
" Note that most plugin managers will do this automatically.
filetype plugin indent on

" This enables Vim's and neovim's syntax-related features. Without this, some
" VimTeX features will not work (see ":help vimtex-requirements" for more
" info).
syntax enable

" Or with a generic interface:
" let g:vimtex_view_general_viewer = 'okular'
" let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'

" VimTeX uses latexmk as the default compiler backend. If you use it, which is
" strongly recommended, you probably don't need to configure anything. If you
" want another compiler backend, you can change it as follows. The list of
" supported backends and further explanation is provided in the documentation,
" see ":help vimtex-compiler".
let g:vimtex_compiler_method = 'latexmk'

" Most VimTeX mappings rely on localleader and this can be changed with the
" following line. The default is usually fine and is the symbol "\".
let maplocalleader = ","

" make it adapted to wsl2
if has('win32') || (has('unix') && exists('$WSLENV'))
      if executable('SumatraPDF.exe')
       let g:vimtex_view_general_viewer = 'SumatraPDF.exe'
      elseif executable('sioyek.exe')
        let g:vimtex_view_method = 'sioyek'
        let g:vimtex_view_sioyek_exe = 'sioyek.exe'
        let g:vimtex_callback_progpath = 'wsl nvim'
      elseif executable('mupdf.exe')
        let g:vimtex_view_general_viewer = 'mupdf.exe'
      endif
else
  let g:vimtex_view_method = 'skim'
  let g:vimtex_view_skim_sync = 1
  let g:vimtex_view_skim_activate = 1
  let g:vimtex_view_skim_reading_bar=1
endif
" let g:vimtex_view_method = 'zathura_simple'

function! SetServerName()
  if has('win32')
    let nvim_server_file = $TEMP . "/curnvimserver.txt"
    let cmd = printf("echo %s > %s", v:servername, nvim_server_file)
  call system(cmd)
  endif
endfunction

augroup vimtex_common
    autocmd!
    autocmd FileType tex call SetServerName()
augroup END
