./mk_clean

echo "Build with tcc"
tcc buzzard2_simpler.c -o artifacts/buzzard2_tcc
echo ""
echo "Build with gcc"
gcc -O0 -g buzzard2_simpler.c -o artifacts/buzzard2_gcc

echo "run with tcc version:"
cat buzzard2/third | ./artifacts/buzzard2_tcc

echo "run with gcc version:"
cat buzzard2/third | ./artifacts/buzzard2_gcc
