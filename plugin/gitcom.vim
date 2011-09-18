" Last Change:  2011 June 15
" Maintainer:   Caglar Gulcehre <caglar@codedanger.com>
" Vim global plugin for committing changes to git on save
" ------------------------------------------------------------------------------
" Exit when your app has already been loaded (or "compatible" mode set)
if exists("g:loaded_GitCommit") || &cp
    finish
endif

let g:loaded_GitCommit= 0.1 " your version number
let s:keepcpo           = &cpo
set cpo&vim

" Public Interface:
" AppFunction: is a function you expect your users to call
" PickAMap: some sequence of characters that will run your AppFunction
" Repeat these three lines as needed for multiple functions which will
" be used to provide an interface for the user
if !hasmapto('<Plug>AppFunction')
    map <unique> <Leader>PickAMap <Plug>AppFunction
endif


" ------------------------------------------------------------------------------
" s:GitCommit: this function is available vi the <Plug>/<script> interface above
" add changes to the git repo
function! s:GitAddAll()
    execute "w!"
    !git add -A
endfunction

"commit changes to the git repo
function! s:GitDiffCommit()
    execute "w!"
    python << EOF
import os
import subprocess

fName = "./.git/COMMIT_EDITMSG"
tmpFname = fName + "_TMP"
cmdCommit = "git commit -a -t " + tmpFname
cmdDiff = "git diff --patience"
stdout_handle = os.popen(cmdDiff, "r")
diffMsg = stdout_handle.read()

FILE = open(tmpFname, 'w')
FILE.write(diffMsg)
FILE.close()
EOF
    !git commit -a -t "./.git/COMMIT_EDITMSG_TMP"
endfunction

"commit changes to the git repo
function! s:GitDiffCommit()
    execute "w!"
    !git commit -a
endfunction

"save and commit
:command WD call s:GitDiffCommit()
:command W call s:GitCommit()
:command A call s:GitAddAll()

"autocmd! BufWritePost * call s:GitCommit()
" ------------------------------------------------------------------------------
let &cpo= s:keepcpo
unlet s:keepcpo
