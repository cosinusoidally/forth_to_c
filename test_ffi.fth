: calloc 1 ;
: wi8    2 ;
: puts   3 ;

10 9 8
100 1 calloc ffi_call
dup dup dup dup dup dup dup
72 swap wi8 ffi_call
1 +
101 swap wi8 ffi_call
2 +
108 swap wi8 ffi_call
3 +
108 swap wi8 ffi_call
4 +
111 swap wi8 ffi_call
5 +
10 swap wi8 ffi_call
puts ffi_call
. . . .
