COMP = g++
FLAGS = -std=c++11 -Wall -g
SRC_DIR = ..
TOKEN = token
INTLIST = intlist
INDEXEDTOKEN = indexedtoken
DLLIST = dllist
INDEXER = indexer
ALL_TESTS = $(TOKEN) $(INTLIST) $(INDEXEDTOKEN) $(DLLIST) $(INDEXER)

# default target
all: $(ALL_TESTS)

# build tests with dependencies (each is a target definition followed by the execution)
# `$@` for target name
# `$^` for dependencies
# below will be: `g++ -std=c++11 -Wall -g -o token token.cpp ../Token.cpp
$(TOKEN): token.cpp $(SRC_DIR)/Token.cpp
	$(COMP) $(FLAGS) -o $@ $^

$(INTLIST): intlist.cpp $(SRC_DIR)/IntList.cpp
	$(COMP) $(FLAGS) -o $@ $^

$(INDEXEDTOKEN): indexedtoken.cpp $(SRC_DIR)/IndexedToken.cpp $(SRC_DIR)/Token.cpp $(SRC_DIR)/IntList.cpp
	$(COMP) $(FLAGS) -o $@ $^

$(DLLIST): dllist.cpp $(SRC_DIR)/DLList.cpp $(SRC_DIR)/IndexedToken.cpp $(SRC_DIR)/Token.cpp $(SRC_DIR)/IntList.cpp
	$(COMP) $(FLAGS) -o $@ $^

$(INDEXER): indexer.cpp $(SRC_DIR)/Indexer.cpp $(SRC_DIR)/DLList.cpp $(SRC_DIR)/IndexedToken.cpp $(SRC_DIR)/Token.cpp $(SRC_DIR)/IntList.cpp
	$(COMP) $(FLAGS) -o $@ $^

# run individual tests
run-token: $(TOKEN)
	@echo "Running $(TOKEN) tests..."
	./$(TOKEN)

run-intlist: $(INTLIST)
	@echo "Running $(INTLIST) tests..."
	./$(INTLIST)

run-indexedtoken: $(INDEXEDTOKEN)
	@echo "Running $(INDEXEDTOKEN) tests..."
	./$(INDEXEDTOKEN)

# these are running from `main` function calls 
run-dllist: $(DLLIST)
	./$(DLLIST)

run-indexer: $(INDEXER)
	./$(INDEXER)

# run all tests - call individual test targets
run: run-token run-intlist run-indexedtoken run-dllist run-indexer
	@echo "========================================="
	@echo "========== All tests completed =========="
	
# clean up
clean:
	rm -rf $(ALL_TESTS)

# warn make that these targets are not real files to be created
.PHONY: all clean run run-token run-intlist run-indexedtoken
