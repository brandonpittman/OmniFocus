" Assumes you have an _of.sh shell script in your PATH
command! -nargs=1 OF :call system('_of.sh ' . "'" . <args> . "'")
