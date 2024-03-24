: calloc_n 1 ;
: wi8_n    2 ;
: puts_n   3 ;
: ri8_n    4 ;
: dlsym_n  5 ;
: generic_call_n  6 ;

var rval

: calloc calloc_n ffi_call rval ! drop drop rval @ ;
: wi8 wi8_n ffi_call drop drop ;
: puts puts_n ffi_call drop ;
: ri8 ri8_n ffi_call rval ! drop rval @ ;
: dlsym dlsym_n ffi_call rval ! drop drop rval @ ;
: generic_call generic_call_n ffi_call ;

: prc swap wi8 ;

var b
var c

: inc_c c @ 1 + c !  c @ ;

: test_main
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

test_main

var str_buf

256 1 calloc str_buf !

var l_offset
var l_len

var out-str
var char

: copy-str
  str_buf @ l_offset @ + ri8 char !
  char @ out-str @ l_offset @ + wi8
  l_offset @ 1 + l_offset !
  char @ 0
  = if
    out-str @
    exit
  then
  tail copy-str
;

: loop-l"
  key dup
  '"' =
  if
   drop
   l_len @ 1 + 1 calloc out-str !
   0 str_buf @ l_len @ + wi8
   exit
  then
  str_buf @ l_len @ + wi8
  l_len @ 1 + l_len !
  tail loop-l" ;

: loop-l-wrap loop-l" ;

: l" key drop 0 l_len ! loop-l-wrap  0 l_offset ! copy-str ;

var str1
var str2
var str3

l" This is a test" str1 !
l" shorter" str2 !
l" short" str3 !
l_len @
. . .
str_buf @ puts

str1 @ puts
str2 @ puts
str3 @ puts
str_buf @ puts

var puts2

l" puts" 0 dlsym puts2 !

l" another test" puts2 @ generic_call

var printf_sym
l" printf" 0 dlsym printf_sym !

: printf printf_sym @ generic_call ;

100 200 300 l" test printf %x %x %x
" printf

: strcpy
  " strcpy called
"
  0 ( FIXME dummy)
  rval ! drop drop rval @
;

var msg1

( globals for otccelf )
var dstk
var ALLOC_SIZE
var TOK_STR_SIZE
var glo
var data
var ind
var prog
var vars
var sym_stk
var tokens

var rmode
l"r" rmode !

l" otccelf start" msg1 !

: init_c
  " init_c called
"
;

: init_globals
  " init_globals called
"
  99999 ALLOC_SIZE !
;

var in_file
var out_file

l" ex1.c" in_file !
l" artifacts/ex1.exe" out_file !

l" int if else while break return for define main " tokens !

: tcc_main
  msg1 @ puts
  init_c
  init_globals
  ALLOC_SIZE @ 1 calloc sym_stk !
  tokens @ sym_stk @ strcpy dstk !
;

tcc_main

sym_stk @ l"
sym_stk 0x%x
" printf

tokens @ puts

dstk @ l"
dstk 0x%x
" printf
