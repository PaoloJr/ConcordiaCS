## Tutorials & Docs
[PC Assembly Book](https://pacman128.github.io/pcasm/) \
[NASM docs](https://www.nasm.us/xdoc/2.16.03/html/nasmdoc0.html) \
[NASM assembly lab](https://labs.bilimedtech.com/nasm/index.html) \
[NASM Tutorial](https://cratecode.com/info/nasm-tutorial) \
[NASM Tutorial_2](https://www.tutorialspoint.com/assembly_programming/index.htm) \
[x86 instruction list](https://en.wikipedia.org/wiki/X86_instruction_listings) \
[x86 OpCode Reference](http://ref.x86asm.net/) \
[x86 Assembly Guide](https://www.cs.virginia.edu/~evans/cs216/guides/x86.html) \
[x86 Registers](https://en.wikibooks.org/wiki/X86_Assembly/X86_Architecture) \
[x86 Registers - uToronto](https://www.eecg.utoronto.ca/~amza/www.mindsec.com/files/x86regs.html) \
[LLDB](https://lldb.llvm.org/#) \
[GDB](https://www.sourceware.org/gdb/) \
[GDB Enhanced Features](https://hugsy.github.io/gef/) \
[ASCII Table](https://www.ascii-code.com/)

## Linux
_some libraries may be needed_
- `build-essential`
- `gcc-multilib` 

[Linux SysCall Table for x86-64](https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/) \
[Linux SysCall Table for x86-32](https://syscalls32.paolostivanin.com/) \
[Linux SysCall Table - Chromium](https://www.chromium.org/chromium-os/developer-library/reference/linux-constants/syscalls/)

_**NASM**_ \
_for building ELF32 object file with debugging details `.o`_ \
`nasm -f elf32 -g -F dwarf -o <output_objectFile> <input_asmFile>`

_for building ELF64 object file with debugging details `.o`_ \
`nasm -f elf64 -g -F dwarf -o <output_objectFile> <input_asmFile>`

_**gcc**_ \
_32-bit_ \
`gcc -m32 -no-pie -nostdlib <object-file -o <output-file>` \
`-nostdlib`, when not using C libraries \
_build shared library_ \
`gcc -m32 -shared -o lib<libName>.so libName.o` \
_main program dynamic-linking to shared library_ \
`gcc -m32 <objectFile> -o <ELF> -L<pathToLib> -l<libName> -ldl -Wl,-rpath<absPathToLib>` \
`-ldl`, to link with `dl` (dynamic-linker) library
- may need to `export LD_LIBRARY_PATH=.:$$LD_LIBRARY_PATH`, to use the current directory for `ld` to link to shared-library
- `Wl` to pass additional options to linker
- `-rpath` (used with `-Wl`) to specify runtime library search path
    - avoids using the `export` command before building the dynamically linked program

_**ld**_ \
_32-bit_ \
`ld -m elf_i386 -o <output_fileName> <input_objectFile>` \
_64-bit static-linking_ \
`ld -o <input_objectFile1> <input_objectFile2> -o <output_fileName>`
- `-l<libName>`, to link with a library
- `-lc`, to link with `libc.a` (static C standard library; `libc.so` (shared object) is the shared library version, for dynamic-linking)
- `-lm`, to link with `libm.a` (static Math Library; `libm.so` (shared object) is the shared library version, for dynamic-linking)
- `-L<pathToSharedLibs`, to link with a specified directory containing share library

_**gdb**_ \
[gdb tutorial](https://www.gdbtutorial.com/gdb_commands) \
[gdb cheatsheet](https://gabriellesc.github.io/teaching/resources/GDB-cheat-sheet.pdf) \
`gdb ./ELF_binary` - to start `gdb` with the executable \
    1.`layout asm` & `layout reg` - show each assembly line and registers \
    2.`break <some line or function name>` - set a breakpoint \
    3.`run` \
    4.`si` - step in \
`refresh` - refreshes the screen (useful when stepping in cause some visual inconsistencies) \
`continue` - to enter input (sometimes required by program)

_**make**_ \
[makefile tutorial](https://makefiletutorial.com/) \
`make` - use MAKEFILE to compile `.asm` and link `.o` to  ELF file \
`make -s` - supress / silence command output messages \
`make clean` - using MAKEFILE `clean` command to remove object and ELF file \ 
`make -f <makeFile>` - choose specific makefile to run

_**file**_ \
`file <filename>` - to view file details

_**readelf**_ \
`readelf -a` - to view all ELF binary file details (headers, sections, symbols etc.)  

_**core dump (current state of program in file after crash)**_ \
`ulimit -c unlimited` - allow kernel to produce unlimited size of core files \

_to change `core_pattern`_
- `sudo su` - root
- `"corePattern" > /proc/sys/kernel/core_pattern`
- "corePattern" could be "./core" (to create core file in crashing-program's directory)
- `gdb <crashing-program> <core-file>` - open gdb using program file and core file
- `x/i $pc` - examine memory instruction at program-counter (could be used at crashing line-number / function)


## Windows
_**NASM**_ \
_for building Win32 API, 32-bit object file `.obj`_ \
`nasm -f win32 -g -o <objectFile.obj> <filePath>`

_**zig build-exe**_ \
`zig build-exe <objectFile> -target x86-windows-gnu -lc`

_**gcc using MinGW, for `.exe`**_ \
`gcc <object-file> -o <output-file>.exe`

_**gcc for `.dll`**_ \
_to make library shareable_
- `gcc -m32 -shared -o <example.dll> <dll.obj>`

_**gcc for `.exe`, linked to `.dll`**_
- `gcc -m32 -o <executable.exe> <inputFile.obj> -L . -l<dllFile.dll>`
- `-L.` to enable linking in current directory
- `-l<dllFile.dll>` for linking to a `.dll` file