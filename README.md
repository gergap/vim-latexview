VIM Latex View plugin
=====================

(C) 2014 Gerhard Gappmeier <gappy1502@gmx.net>

This plugin implements forward search using SyncTex.

Why
---

I recently stumbled over the SyncTex feature and wanted to use it with Vim and
Okular, because I'm always writing LaTeX documents using Vim, latexmk, pdflatex
and Okular.

Unfortunately it was not easy to find information about that and the LaTeX vim
plugins that support it are all full blown and change almost everything (tags,
syntax, auto completion, ...) which I don't want.  I just want to
improve the viewing part using Okular. I prefer using UltiSnips for editing
LaTeX and use normal vim functionality for navigation including a tags file.

So I started to write an own latex-view plugin which just does what I want. If
this is all that you need this might be the right plugin for you. Otherwise
take a look at http://vim-latex.sourceforge.net and
http://atp-vim.sourceforge.net.

Installation
------------

Use pathogen and clone this repo into ~/.vim/bundle as usual.


Usage
-----

Notes:

* Your main LaTeX file needs the "\synctex=1" directive in the preamble
* Your other files should contain a comment in the file header referring to
  to your main LaTeX file: %!TeX root = master.tex
  This comment must be within the first 5 lines.
* You need to create the PDF using pdflatex

Notes on backward search:
Okular also supports backward search.
Therefore you need to open Settings->Configure Okular...->Editor Settings
and select "Custom Text Editor". In the command field you need to enter:
vim --servername VIM --remote-silent +%l %f

You need to start vim using "vim --server VIM <file>". This starts vim in
server mode. This way Okular can send you commands for backward search.
Tip: create an "alias vim='vim --server VIM'" in your ~/.bashrc.

Now you can jump from LaTeX to PDF file (forward-search) and from the PDF
file to the corresponding line in your LaTeX file (backward-search).

Enjoy the power of Vim + LaTeX + Okular



