ASM = nasm
ASM_FLAGS = -f elf32 -g -F dwarf
LINKER = gcc
LINKER_FLAGS = -m32 -no-pie -ldl
MAIN_FILE = main.asm
EXT_SUBFILE = extSubPerfSquare.asm
LIBRARY = libextSubPerfSquare.so

all: program

program: main.o $(LIBRARY) 
	$(LINKER) $(LINKER_FLAGS) -o program main.o -L/mnt/c/Users/PaoloJr/Documents/GitHub/ConcordiaCS/COMP5201/programmingAssignment3 -lextSubPerfSquare

libextSubPerfSquare.so: extSubPerfSquare.o 
	$(LINKER) -m32 -shared -o $(LIBRARY) extSubPerfSquare.o

main.o: $(MAIN_FILE)
	$(ASM) $(ASM_FLAGS) $(MAIN_FILE) -o main.o

extSubPerfSquare.o: $(EXT_SUBFILE)
	$(ASM) $(ASM_FLAGS) $(EXT_SUBFILE) -o extSubPerfSquare.o

clean:
	rm -f program main.o extSubPerfSquare.o $(LIBRARY)

.PHONY: all clean
