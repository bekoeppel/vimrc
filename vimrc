set nocompatible

" Required Vundle setup
filetype off
set runtimepath+=~/.vim/bundle/vundle/
call vundle#rc()

" NOTE: after adding something here, run :VundleInstall
Plugin 'gmarik/vundle'

Plugin 'editorconfig/editorconfig-vim'
Plugin 'tpope/vim-commentary'
Plugin 'plasticboy/vim-markdown'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-abolish'
Plugin 'nelstrom/vim-visual-star-search'
Plugin 'mbbill/undotree'
Plugin 'dhruvasagar/vim-table-mode'
Plugin 'leafgarland/typescript-vim'

call vundle#end()


" VIM colors
color github

" Syntax highlighting
syntax enable

" 1 Tab is 4 Spaces, immediately expanded
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
" for *.go files, we want tabs
autocmd FileType go setlocal noexpandtab
" for *.yaml files we want 2 spaces
autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab
" load filetype specific indent files from ~/.vim/indent/filetype.vim
filetype indent on
" Spaces and tabs can be configured with .editorconfig
let g:EditorConfig_exec_path = '/usr/local/bin/editorconfig'
" auto-indent on enter
set autoindent
" read modeline (e.g. vi:noai:sw=3 ts=6) from the first 5 lines of a file
set modeline
set modelines=5
" don't insert double space after a sentence when joining lines
set nojoinspaces

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
au BufReadCmd *.ova call tar#Browse(expand("<amatch>"))


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

" useful settings from http://stevelosh.com/blog/2010/09/coming-home-to-vim/
set encoding=utf-8
"set cursorline
set ttyfast

" in visual, evaluate the selected formuala, append ' = ' and the result of the calculation
vnoremap Q ygv<Esc>a = <C-r>=<C-\>e getreg('"')<CR><Esc><Esc>


" show diff between current state and last saved state
command! DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis

" convert a Blob copied from FreePlane to a nice text listing
function! MindmapPrettyPrint(tw) 
    set ts=4 sts=4 sw=4 expandtab
    retab
    silent 2,$g/^[^[:space:]]/norm O
    %g/\v^[[:space:]]{4}/-1s/\v^([^[:space:]].*[^:])$/\1:/
    %s/\v^( {2,})  /\1- /
    exe ':set textwidth='.a:tw
    %g/.*/norm gqj
    %s/[<>]//g
endfunction

" convert a Daily Sync node into an update that I can paste to slack
" function! DailySync()
"     :set ts=4 sts=4 sw=4 expandtab
"     :retab
"     :%g/^\s*Gestern$/-1j
" 
"     if strftime('%a') == "Mon"
"         :%s/^Daily Sync Gestern/Good morning, my updates for the daily sync... \r*Friday:*/
"     else
"         :%s/^Daily Sync Gestern/Good morning, my updates for the daily sync... \r*Yesterday:*/
"     endif
"     :%s/^\s*Heute/*Today:*/
"     :%s/^\s*Inputs . Fragen/Open questions:/
"     :2,$g/^[^[:space:]]/norm O
"     :%s/\v^( {2,})  /\1- /
" endfunction
function! DailySync()
    :%!/home/beni/Applications/daily-sync.pl
endfunction



" convert a copy-paste from JIRA stories into Confluence table
function! SprintWikiPage()
    :set ts=4 sts=4 sw=4 expandtab
    " add a tab after each line
    :%s/$/\t/
    " join each task onto one line
    :%v/\v^ (Task|Bug)/-1j
    " delete first line
    :1d
    " format table
    :%s/^\v^\s*%(Task|Bug)\t(.{-})\t\s*(.{-})\t\s*(.{-})\t\s*(.{-})\t.*/|{jira:\1}|\2|\3|\4| | |/g
    " insert header
    call append(0, "||JIRA Issue||Epic||Specific Task||Assignee||Review 1||Final Review||")
endfunction

" convert a copy-paste from JIRA stories into Excel table
function! SprintToExcel()
    :set ts=4 sts=4 sw=4 expandtab
    " add a tab after each line
    :%s/$/\t/
    " remove fotter
    :%g/\v^\d*.\d* of \d*Refresh results/d
    :%g/^Atlassian JIRA Project Management Software/d
    :$d
    " remove "Actions" button
    :%s/\s*Actions\s*$//
    " join each task onto one line
    :%v/\v^ (Task|Bug)/-1j
    " delete first line
    :1d
    " cleanup
    :%s/^\s*//
    " insert header
    call append(0, "Type	Key	Epic	Epic Link	Summary	Assignee	Priority	Status	Resolution	Created	Updated	Due	Story Points")
endfunction

" convert a copy-paste from JIRA stories into Mindmap links (only for my own stories)
function! SprintToMindmap()
    :set ts=4 sts=4 sw=4 expandtab
    " add a tab after each line
    :%s/$/\t/
    " join each task onto one line
    :%v/\v^ (Task|Bug)/-1j
    " delete first line
    :1d
    " delete what is not assigned to me
    :%v/Benedikt K.ppel/d
    " format table
    :%s/^\v^\s*%(Task|Bug)\t(.{-})\t\s*(.{-})\t\s*(.{-})\t\s*(.{-})\t.*/\3\r\thttps:\/\/jira.locatee.ch\/browse\/\1/g
endfunction


" When copying from Google Calendar, dates look like this
" Thursday, January 25
" 08:00 – 09:00
"
" I want them to look like this
" Thu, 25. Jan 2018: 08:00 - 09:00
function! GoogleCalendarDateFormat()
    :set ts=4 sts=4 sw=4 expandtab
    " add a : to all lines that don't contain a –, but are not empty
    :%v/ – /s/..*$/&: /
    " join lines that contain a – to the previous line
    :%g/ – /-1j
    " remove newlines
    :%g/^\s*$/d
    " replace date
    "date '+%A, %B %e' -d 'Thursday, January 25'
   
endfunction


" cleanup Evernote note, saved as RTF, pasted from Windows
function! CleanupEvernoteToBullets()
    :%s/•	/  - /
    :%s/o	/      - /
    :%s/	/          - /
endfunction


" open up to 100 tabs
set tabpagemax=100

" more characters will be sent to the screen for redrawing
set ttyfast
" time waited for key press(es) to complete. It makes for a faster key response
set ttimeout
set ttimeoutlen=50

" disable line wrap
set nowrap
" toggle line wrap with Alt-w
nnoremap <unique> <M-w> :set wrap!<CR>
" toggle line wrap in insert mode with Alt-w. See https://vi.stackexchange.com/a/2363/18001 for details
execute "set <M-w>=\ew"
inoremap <unique> <M-w> <C-o>:set wrap!<CR>

" disable ex mode
nnoremap Q <nop>

" make ":vim" do the same as ":tabe"
cnoreabbrev vim tabe

" Make Shift-Tab do << (decrement indent by one tab)
" for command mode
nnoremap <Tab> >>
nnoremap <S-Tab> <<
" for insert mode
inoremap <S-Tab> <C-d>
