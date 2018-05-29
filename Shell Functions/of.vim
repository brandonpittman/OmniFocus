" Assumes you have an 'of' shell script in your PATH
command! -nargs=1 OF :call system('of ' . "'" . <args> . "'")
