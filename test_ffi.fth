: calloc 1 ;
: wi8    2 ;
: puts   3 ;

100 1 calloc ffi_call
'H' swap wi8 ffi_call
