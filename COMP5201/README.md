#### Tutorials
[NASM docs](https://www.nasm.us/xdoc/2.16.03/html/nasmdoc0.html)
[NASM assembly code](https://labs.bilimedtech.com/nasm/index.html) \
[NASM Tutorial](https://cratecode.com/info/nasm-tutorial)


#### NASM command
_for building 32-bit object file `.obj`_ \
`nasm -f win32 <filePath>`

#### Zig build-exe command
`zig build-exe <objectFile> -target x86-windows-gnu -lc`

#### gcc command (using MinGW - for .exe, on Windows)
`gcc <object-file> -o <output-file>.exe`