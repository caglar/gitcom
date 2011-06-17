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
" s:AppFunction: this function is available vi the <Plug>/<script> interface above
function! s:GitCommit()
    execute "w!"
"    let out = system("ls -alh")
 "   echo out
    let cmd = "git commit"
    let output = system(cmd)
    echo output
endfunction

"save and commit
:command W call s:GitCommit()
"autocmd! BufWritePost * call s:GitCommit()
" ------------------------------------------------------------------------------
let &cpo= s:keepcpo
unlet s:keepcpo
