COMP = g++
FLAGS = -std=c++11 -Wall -g
SRC_DIR = ..
INDEXEDTOKEN = indexedtoken
INDEXER = indexer
ALL_TESTS = $(INDEXEDTOKEN) $(INDEXER)

# default target
all: $(ALL_TESTS)

# build tests with dependencies (each is a target definition followed by the execution)
# `$@` for target name
# `$^` for dependencies
# below will be: `g++ -std=c++11 -Wall -g -o indexedtoken indexedtoken.cpp ../IndexedToken.cpp
$(INDEXEDTOKEN): indexedtoken.cpp $(SRC_DIR)/IndexedToken.cpp
	$(COMP) $(FLAGS) -o $@ $^

$(INDEXER): indexer.cpp $(SRC_DIR)/Indexer.cpp $(SRC_DIR)/IndexedToken.cpp
	$(COMP) $(FLAGS) -o $@ $^

# run individual tests
run-indexedtoken: $(INDEXEDTOKEN)
	./$(INDEXEDTOKEN)

# these are running from `main` function calls 
run-indexer: $(INDEXER)
	./$(INDEXER)

# run all tests - call individual test targets
run: run-indexedtoken run-indexer
	@echo "========================================="
	@echo "========== All tests completed =========="
	@echo ""
	
# clean up
clean:
	rm -rf $(ALL_TESTS)

# warn make that these targets are not real files to be created
.PHONY: all clean run run-indexedtoken
