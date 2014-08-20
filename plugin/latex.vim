" Viewing LaTeX documents using SyncTex forward search
" Author: Gerhard Gappmeier
"
" This uses the SyncTex feature supported by Okular PDF viewer (and others) to
" implement forward search. This means when editing a LaTeX file and pressing
" <leader>-f vim will open Okular (if not already open) and jumps to the
" corresponding line in the PDF.
"
" Notes:
"
" * Your main LaTeX file needs the "\synctex=1" directive in the preamble
" * Your other files should contain a comment in the file header referring to
"   to your main LaTeX file: %!TeX root = master.tex
"   This comment must be within the first 5 lines.
" * You need to create the PDF using pdflatex
"
" Notes on backward search:
" Okular also supports backward search.
" Therefore you need to open Settings->Configure Okular...->Editor Settings
" and select "Custom Text Editor". In the command field you need to enter:
" vim --servername VIM --remote-silent +%l %f
"
" You need to start vim using "vim --server VIM <file>". This starts vim in
" server mode. This way Okular can send you commands for backward search.
" Tip: create an "alias vim='vim --server VIM'" in your ~/.bashrc.
"
" Now you can jump from LaTeX to PDF file (forward-search) and from the PDF
" file to the corresponding line in your LaTeX file (backward-search).
"
" Enjoy the power of Vim + LaTeX + Okular
"

if exists("s:loaded_viewlatex")
    finish
else
    let s:loaded_viewlatex = 1
endif

" configure document viewer
let g:DocumentViewer = "okular --unique"
"let g:DocumentViewer = "zathura"
let g:Ext = "pdf"

"" The function FindRoot() is from the script
"" live-latex-preview.vim by Kevin C. Klement
"" klement <at> philos <dot> umass <dot> edu
"" Search for root file
function! FindRoot()
    let g:RootFile = expand("%")
    for linenum in range(1,5)
        let linecontents = getline(linenum)
        if linecontents =~ 'root\s*='
           let g:RootFile = expand("%:p:h")."/".substitute(linecontents, '.*root\s*=\s*', "", "")
           let g:RootFile = substitute(g:RootFile, '\s*$', "", "")
           echom "RootFile=".g:RootFile
        endif
    endfor
    let g:RootFileName = substitute(g:RootFile, '\.tex$', "", "")
endfunction
call FindRoot()

" Forward search
function! PDFForward()
    call FindRoot()
    if filereadable(g:RootFileName.".".g:Ext)
        let cmd = g:DocumentViewer . " \"".g:RootFileName.".".g:Ext."\"\#src:".line('.').expand("%:p")." &" "
        "echom cmd
        silent! call system(cmd)
    else
        echo "Output file not readable."
    endif
endfunction

" Mapping forward search to <leader>-f
nmap <Leader>f :call PDFForward()<CR>

