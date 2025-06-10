# Variables
ASM = nasm
ASM_FLAGS = -f elf64 -g -F dwarf
LD = ld
LD_FLAGS = 

# default target
all: program

# Create executables
program: file1.o file2.o
	$(LD) $(LD_FLAGS) -o program file1.o file2.o

# Create object files
file1.o: file1.asm
	$(ASM) $(ASM_FLAGS) file1.asm -o file1.o

file2.o: file2.asm
	$(ASM) $(ASM_FLAGS) file2.asm -o file2.o

# Clean up
clean:
	rm -f file1.o file2.o program

# Phony targets
.PHONY: all clean