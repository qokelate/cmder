#!/bin/zsh


#command="cmake -DCMAKE_C_STANDARD=11 -DCMAKE_CXX_STANDARD=14 -DCMAKE_POSITION_INDEPENDENT_CODE=1"
#[ -f "$(where sh | head -n 1)" ] && command="$command -G 'MSYS Makefiles'"
#[ -f "$(where sh | head -n 1)" ] || command="$command -G 'MinGW Makefiles'"

#clang_prefix="/mingw64/bin/clang/"
#command="$command -DCMAKE_C_COMPILER=${clang_prefix}clang -DCMAKE_CXX_COMPILER=${clang_prefix}clang++ -DCMAKE_AR=${clang_prefix}llvm-ar -DCMAKE_LINKER=${clang_prefix}llvm-ld -DCMAKE_NM=${clang_prefix}llvm-nm -DCMAKE_OBJDUMP=${clang_prefix}llvm-objdump -DCMAKE_RANLIB=${clang_prefix}llvm-ranlib"

command="cmake -G 'MSYS Makefiles' '-D_GLIBCXX_USE_CXX11_ABI=0' '-DD_GLIBCXX_USE_CXX11_ABI=0' '-DCMAKE_INSTALL_PREFIX=$PWD/output' '-DCMAKE_POSITION_INDEPENDENT_CODE=1' '-DCMAKE_BUILD_TYPE=Release'"

for a in "$@"; do
  command="$command '$a'"
done

echo "[INFO] CMake command: $command"
eval "$command"

exit
