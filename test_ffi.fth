: calloc 1 ;
: wi8    2 ;
: puts   3 ;
: prc swap wi8 ffi_call ;

var b
var c

: inc_c c @ 1 + c !  c @ ;

: tcc_main
10 9 8
100 1 calloc ffi_call b !
b @ c !
c @ 72 prc
inc_c 101 prc
inc_c 108 prc
inc_c 108 prc
inc_c 111 prc
inc_c '\n' prc
b @ puts ffi_call
. . . .
;

tcc_main

: foo " Hello
" ;
foo .
