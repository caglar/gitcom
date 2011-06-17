let fname = "./.git/COMMIT_EDITMSG"
let alist = []
for line in readfile(fname, '', 10)
    if line =~ 'modified' |
        let line = system("git diff --patience")."\n"."==================================================="."\n"
        call add(alist, line)
    | endif
endfor
call writefile(alist, fname, '')
