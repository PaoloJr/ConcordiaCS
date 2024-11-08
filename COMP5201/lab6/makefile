# Variables
ASM = nasm
ASM_FLAGS = -f elf32 -g -F dwarf
LD = ld
LD_FLAGS = -m elf_i386

# Targets
all: recursion stack

# Create executables
recursion: recursion.o
	$(LD) $(LD_FLAGS) -o recursion recursion.o

stack: stack.o
	$(LD) $(LD_FLAGS) -o stack stack.o

# Create object files
recursion.o: recursion.asm
	$(ASM) $(ASM_FLAGS) recursion.asm -o recursion.o

stack.o: stack.asm
	$(ASM) $(ASM_FLAGS) stack.asm -o stack.o

# Clean up
clean:
	rm -f recursion.o stack.o recursion stack

# Phony targets
.PHONY: all clean