### compiler options
_run with optimizations_
- `g++ <source>.cpp`

_run with debugging information (for `gdb`)_
- `g++ -g -std=c++14 <source>.cpp -o <output_name>`
- `-g` for debugging information
- `-std` for setting language standard

---

### gdb commands
_load program in `gdb`_
- `gdb <program_name>`

_run program from beginning_
- `run`
- `r`

_set breakpoints_
- line number --> `break <number>`
- function / symbol --> `break <func_name>`
- `break <num_fun>`
- `b <num_func>`

_step forward_ 
- `next`
- `n`
- usually to execute an entire function

_show some lines before and after current line (for context)_
- `list`
- `l`
- `l <num>` --> list from a specific line number

_show some symbol value_
- `print <variable_etc>`
- `p <variable_etc>`

_move in the call stack_
- `up`
- `down`

_display value of symbol at subsequent commands (keep track of symbols)_
- `display <var_func>`
- then run `next` to see the next line with the (new) value of `<var_func>`

_stop displaying_
- `undisplay <id>`

_print entire call stack (useful for checking stacktrace)_
- `backtrace`
- `bt`

_go inside a function call (usually at breakpoint)_
- `step`
- `s`
- usually to execute one line

_keep running code (until next breakpoint)_
- `continue`
- `c`

_finish current function call (stack frame) and stop_
- `finish`

_keep track of variable_
- `watch <var>`
- `continue` to see watch-point changes

_show breakpoints / watchpoints_
- `info [breakpoints | watchpoints]`
- `info [break | watch]`
- `i [b | wat]`

_delete breakpoints / watchpoints_
- `delete <id>`
- `delete` --> delete all breakpoints and watchpoints

_get type_
- `whatis <var>`
- `what <var>`

_record code execution_
- `target record-full`
- can then run reverse-debugging commands!

_reverse-debugging_
- `reverse-next`, `rn`
- `reverse-step`, `rs`
- `reverse-continue`, `rc`
- `reverse-finish`

_set variable_
- `set var <var> = <value>`
- useful for using different values when running program