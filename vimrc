execute pathogen#infect()

if has("autocmd")
    filetype on
    filetype indent on
    filetype plugin on
endif
syntax on
set number


:set ai
:set nu
:syntax on
":color peachPuff
:color github
:set ruler

set wildmode=longest,list,full
set wildmenu

" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'


"let g:Tex_CompileRule_pdf = 'pdflatex -synctex=1 -src-specials -interaction=nonstopmode $*'
let g:Tex_UseMakefile = 1
let g:Tex_ViewRule_pdf = 'okular --unique'


function! SyncTexForward()
	let s:syncfile = fnamemodify(fnameescape(Tex_GetMainFileName()), ":r").".pdf"
	let execstr = "silent !okular --unique ".s:syncfile."\\#src:".line(".").expand("%\:p").' &'
	exec execstr
	redraw!
endfunction
nnoremap <Leader>f :call SyncTexForward()<CR>
:let Tex_FoldedSections=""
:let Tex_FoldedEnvironments=""
:let Tex_FoldedMisc=""

let g:Tex_IgnoredWarnings =
      \'Underfull'."\n".
      \'Overfull'."\n".
      \'specifier changed to'."\n".
      \'You have requested'."\n".
      \'Missing number, treated as zero.'."\n".
      \'There were undefined references'."\n".
      \'Latex Warning:'."\n".
      \'Citation %.%# undefined'
let g:Tex_IgnoreLevel = 8

set modeline
set modelines=5

command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis

" highlight *.txt files in ~/work/src/wiki/ automatically with Dokuwiki syntax
autocmd BufRead,BufNewFile ~/work/src/wiki/*.txt set filetype=Dokuwiki

autocmd BufNewFile,BufRead $HOME/work/src/personal/mentor-bot/* set nowrap tabstop=2 shiftwidth=2 softtabstop=2 expandtab
