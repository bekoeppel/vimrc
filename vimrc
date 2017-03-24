" Pathogen as bundle/plugin manager
execute pathogen#infect()

" VIM colors
color github

" Syntax highlighting
syntax enable

" 1 Tab is 4 Spaces, immediately expanded
set tabstop=4
set softtabstop=4
set expandtab
" load filetype specific indent files from ~/.vim/indent/filetype.vim
filetype indent on
" Spaces and tabs can be configured with .editorconfig
let g:EditorConfig_exec_path = '/usr/local/bin/editorconfig'
" auto-indent on enter
set autoindent
" read modeline (e.g. vi:noai:sw=3 ts=6) from the first 5 lines of a file
set modeline
set modelines=5

" UI config
" show line numbers
set number 
" control expansion: first complete to the longest common string, then list
" the candidates, then expand to the next full match.
set wildmode=longest,list,full
set wildmenu
" redraw only when needed, e.g. not during macros
set lazyredraw
" highlight matching braces
set showmatch
" show ruler at bottom with current line, column and % of file
set ruler

" file handling
" open JAR, XPI, IPA, APK, DOCX and XLSX files as ZIP
au BufReadCmd *.jar,*.xpi,*.ipa,*.apk,*.docx,*.xlsx call zip#Browse(expand("<amatch>"))

" Emacs bindings in control mode
cnoremap <C-a>  <Home>
cnoremap <C-b>  <Left>
cnoremap <C-f>  <Right>
cnoremap <C-d>  <Delete>
" haven't found a way to kill the whole line
cnoremap <C-k>  <Delete>
cnoremap <M-b>  <S-Left>
cnoremap <M-f>  <S-Right>
cnoremap <M-d>  <S-right><Delete>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>
cnoremap <Esc>d <S-right><Delete>
cnoremap <C-g>  <C-c>

" show diff between current state and last saved state
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis

" convert a Blob copied from FreePlane to a nice text listing
function! MindmapPrettyPrint() 
    :set ts=4 sts=4 sw=4 expandtab
    :retab
    :2,$g/^[^[:space:]]/norm O
    :%g/\v^[[:space:]]{4}/-1s/\v^([^[:space:]].*[^:])$/\1:/
    :%s/\v^( {2,})  /\1- /
    :%g/.*/norm gqj
endfunction

" convert a Daily Sync node into an update that I can paste to slack
function! DailySync()
    :set ts=4 sts=4 sw=4 expandtab
    :retab
    :%g/^\s*Gestern$/-1j

    if strftime('%a') == "Mon"
        :%s/^Daily Sync Gestern/Good morning, my updates for the daily sync... *Friday:*/
    else
        :%s/^Daily Sync Gestern/Good morning, my updates for the daily sync... *Yesterday:*/
    endif
    :%s/^\s*Heute/*Today:*/
    :%s/^\s*Inputs . Fragen/Open questions:/
    :2,$g/^[^[:space:]]/norm O
    :%s/\v^( {2,})  /\1- /
endfunction

