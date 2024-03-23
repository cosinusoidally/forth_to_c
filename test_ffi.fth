: calloc 1 ;
: wi8    2 ;
: puts   3 ;

var b
var c

: inc_c c @ 1 + c ! ;

10 9 8
100 1 calloc ffi_call b !
b @ c !
c @
72 swap wi8 ffi_call
c @
1 +
101 swap wi8 ffi_call
c @
2 +
108 swap wi8 ffi_call
c @
3 +
108 swap wi8 ffi_call
c @
4 +
111 swap wi8 ffi_call
c @
5 +
10 swap wi8 ffi_call
b @
puts ffi_call
. . . .
