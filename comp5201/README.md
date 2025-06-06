## Linux
_some libraries may be needed_
- `build-essential`
- `gcc-multilib` 

_**NASM**_ \
_for building ELF32 object file with debugging details `.o`_ \
`nasm -f elf32 -g -F dwarf -o <output_objectFile> <input_asmFile>`

_for building ELF64 object file with debugging details `.o`_ \
`nasm -f elf64 -g -F dwarf -o <output_objectFile> <input_asmFile>`

_**ld**_ \
_32-bit_ \
`ld -m elf_i386 -o <output_fileName> <input_objectFile>` \
_64-bit static-linking_ \
`ld -o <input_objectFile1> <input_objectFile2> -o <output_fileName>`
- `-l<libName>`, to link with a library
- `-lc`, to link with `libc.a` (static C standard library; `libc.so` (shared object) is the shared library version, for dynamic-linking)
- `-lm`, to link with `libm.a` (static Math Library; `libm.so` (shared object) is the shared library version, for dynamic-linking)
- `-L<pathToSharedLibs`, to link with a specified directory containing share library


_**core dump (current state of program in file after crash)**_ \
`ulimit -c unlimited` - allow kernel to produce unlimited size of core files \

_to change `core_pattern`_
- `"corePattern" > /proc/sys/kernel/core_pattern`
- "corePattern" could be "./core" (to create core file in crashing-program's directory)
- `gdb <crashing-program> <core-file>` - open gdb using program file and core file
- `x/i $pc` - examine memory instruction at program-counter (could be used at crashing line-number / function)


## Windows
_**NASM**_ \
_for building Win32 API, 32-bit object file `.obj`_ \
`nasm -f win32 -g -o <objectFile.obj> <filePath>`