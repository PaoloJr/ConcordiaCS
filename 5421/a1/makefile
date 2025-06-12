COMP = g++
COMMON_FLAGS = -std=c++11 -Wall -g
ASAN_FLAGS = $(COMMON_FLAGS) -fsanitize=address -O0 -fno-omit-frame-pointer
SOURCES = Token.cpp IntList.cpp IndexedToken.cpp DLList.cpp Indexer.cpp IndexerUI.cpp main.cpp
TARGET = TextIndexer
TARGET_ASAN = $(TARGET)_asan

# default target
all: clean $(TARGET) $(TARGET_ASAN)

# non-asan build compile directly from source files to executable
$(TARGET): $(SOURCES)
	$(COMP) $(COMMON_FLAGS) -o $(TARGET) $(SOURCES)

# asan build
$(TARGET_ASAN): $(SOURCES)
	$(COMP) $(ASAN_FLAGS) -o $(TARGET_ASAN) $(SOURCES)

# clean up
clean:
	rm -f $(TARGET) $(TARGET_ASAN)

# run program
run: $(TARGET)
	./$(TARGET)

run-asan: $(TARGET_ASAN)
	./$(TARGET_ASAN)

.PHONY: all clean run
