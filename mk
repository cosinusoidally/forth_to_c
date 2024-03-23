./mk_clean

echo "Build with tcc"
tcc buzzard2_simpler.c -o artifacts/buzzard2_tcc
echo ""
echo "Build with gcc"
gcc -O0 -g buzzard2_simpler.c -o artifacts/buzzard2_gcc
echo "Build with otccelf"
../tcc_bootstrap_alt/otccelf/artifacts/otccelf_js3.exe buzzard2_simpler.c artifacts/buzzard2_otccelf
chmod +x artifacts/buzzard2_otccelf

echo "run with tcc version:"
cat buzzard2/third test.fth | ./artifacts/buzzard2_tcc

echo "run with gcc version:"
cat buzzard2/third test.fth | ./artifacts/buzzard2_gcc

echo "run with otccelf version:"
cat buzzard2/third test.fth | ./artifacts/buzzard2_otccelf

ls -l artifacts
