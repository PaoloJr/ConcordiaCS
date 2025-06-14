### cppcheck
_static analysis, with all checks and specific C++ standard applied, of all source and header files_
- `cppcheck --enable=all --std=c++11 *.cpp *.h`

_type of checks (in the `all` specifier)_
- `warning`
- `style`
- `performance`
- `portability`
- `information`
- `ununsedFunction`
- `missingInclude`
- use `,` separator

_other options_
- `--verbose` --> output more detailed error information
- `--errorlist` --> print list of all error messages in xml format
- `--suppress=missingIncludeSystem` --> suppress warnings about `include`
- `--suppress=syntaxError` --> suppress syntax errors
- `--check-level=exhaustive` --> deeper analysis
- `--language=c++` --> explicit reference to the language (removes warnings about `C` code)

error IDs are found at the end of each error output, in `[]`
- ex: `performance: Function parameter 'data' should be passed by const reference. [passedByValue]`

---

### mtrace
_memory leak tracking (mostly for pure C code)_
#### add mtrace(); at the start
- `mtrace()` will install hook functions for the memory allocation functions (`malloc`, `realloc`, `memalign`, `free`)
- these hook functions record tracing information about memory allocation and deallocation (in C++: `new` and `delete`)
- ensure program is compiled with debugging options; `-g`
- add before running program (or can `export`)
    - `LD_PRELOAD=/usr/lib64/libc_malloc_debug.so.0 MALLOC_TRACE=mtrace.log ./<ELF>`
    - could also be: `LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libc_malloc_debug.so.0 MALLOC_TRACE=mtrace.log ./<ELF>`
- `./<ELF>`
- `mtrace ./<ELF> mtrace.out`
- mtrace may report "Free was never alloc'd" warnings for memory allocated before the `mtrace()` call or for internal C library operations. These are usually not bugs in your application.

---

### valgrind
- `valgrind --leak-check=yes <ELF>`
- this uses the `memcheck` tool within `valgrind`
- other options:
    - `--leak-check=full`
    - `--show-leak-kinds=all` --> `definite` and `possible`
    - `--track-origins=yes` --> show origins of undefined values

---

### perf
- `perf stat <ELF>` --> gather performance counter stats
- `-e` --> for events, like `branches`, `branch-misses`