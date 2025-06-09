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

_other options_
- `--verbose` --> output more detailed error information
- `--errorlist` --> print list of all error messages in xml format
- `--suppress=missingIncludeSystem` --> suppress warnings about `include`
- `--suppress=syntaxError` --> suppress syntax errors
- `--check-level=exhaustive` --> deeper analysis

error IDs are found at the end of each error output, in `[]`
- ex: `performance: Function parameter 'data' should be passed by const reference. [passedByValue]`


---

### memory leak tracking with mtrace
#### add mtrace(); at the start
- `export MALLOC_TRACE=mtrace.log`
- `./TextIndexer`
- `mtrace ./TextIndexer mtrace.log`

---

### valgrind
- `valgrind --leak-check=full <ELF>`

---

### perf
- `perf stat <ELF>` --> gather performance counter stats
- `-e` --> for events, like `branches`, `branch-misses`