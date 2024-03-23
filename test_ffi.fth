: calloc_n 1 ;
: wi8_n    2 ;
: puts_n   3 ;

var rval

: calloc calloc_n ffi_call rval ! drop drop rval @ ;
: wi8 wi8_n ffi_call drop drop ;
: puts puts_n ffi_call drop ;

: prc swap wi8 ;

var b
var c

: inc_c c @ 1 + c !  c @ ;

: tcc_main
10 9 8 7
100 1 calloc b !
b @ c !
c @ 72 prc
inc_c 101 prc
inc_c 108 prc
inc_c 108 prc
inc_c 111 prc
inc_c '\n' prc
b @ puts
b @ 1 + puts
. . . .
;

tcc_main

var str_buf

256 1 calloc str_buf !

var l_offset
var l_len

: loop-l"
  key dup
  '"' =
  if
   drop
   exit
  then
  str_buf @ l_len @ + wi8
  l_len @ 1 + l_len !
  tail loop-l" ;

: l" key drop 0 l_len ! loop-l" ;

l" This is a test
"
l_len @
. . .
str_buf @ puts
