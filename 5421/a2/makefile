COMP = g++
FLAGS = -std=c++11 -Wall -g
SOURCES = IndexedToken.cpp Indexer.cpp IndexerUI.cpp main.cpp
TARGET = TextIndexerSTL

# default target
all: $(TARGET)

# compile directly from source files to executable
$(TARGET): $(SOURCES)
	$(COMP) $(FLAGS) -o $(TARGET) $(SOURCES)

# clean up
clean:
	rm -f $(TARGET)

# run program
run: $(TARGET)
	./$(TARGET)

.PHONY: all clean run
