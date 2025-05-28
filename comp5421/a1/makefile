CXX = g++
CXXFLAGS = -std=c++11 -Wall

SOURCES = Token.cpp IntList.cpp IndexedToken.cpp DLList.cpp Indexer.cpp IndexerUI.cpp
OBJECTS = $(SOURCES:.cpp=.o)
TARGET = TextIndexer

$(TARGET): $(OBJECTS)
    $(CXX) $(CXXFLAGS) -o $(TARGET) $(OBJECTS)

%.o: %.cpp
    $(CXX) $(CXXFLAGS) -c $<

clean:
    rm -f $(OBJECTS) $(TARGET)