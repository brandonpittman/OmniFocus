" Assumes you have an omnifocus shell script in your PATH
command! -nargs=1 OF :call system('omnifocus ' . "'" . <args> . "'")
