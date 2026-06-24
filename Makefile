.DEFAULT_GOAL := all

BUILD_DIR := ./build
BIN_DIR := ./bin
SRC_DIR := ./src
TEST_DIR := ./test
INC_DIR := ./include


SRCS := main.cpp $(shell find $(SRC_DIR) -name '*.cpp')
OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)
OBJS_NO_MAIN := $(filter-out $(BUILD_DIR)/main.cpp.o, $(OBJS))
EXEC_BIN := main


TEST_SRCS := $(shell find $(TEST_DIR) -name '*_test.cpp')
TEST_OBJS := $(TEST_SRCS:%=$(BUILD_DIR)/%.o)
TEST_BINS := $(patsubst $(TEST_DIR)/%.cpp,$(BIN_DIR)/%,$(TEST_SRCS))


DEPS := $(OBJS:.o=.d) $(TEST_OBJS:.o=.d)


CXX := clang++
CXXFLAGS := -std=c++23 -Wall -Wextra -pedantic -Werror -fsanitize=address,leak,undefined
INC_FLAGS := $(addprefix -I,$(INC_DIR))
CPPFLAGS := $(INC_FLAGS) -MMD -MP
LDFLAGS := -fsanitize=address,leak,undefined
LIBS := -lgtest -lgtest_main -pthread


# Build Object files
$(BUILD_DIR)/%.cpp.o: %.cpp
	mkdir -p $(dir $@)
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@

# Build Main executable
$(EXEC_BIN): $(OBJS)
	$(CXX) $(LDFLAGS) $^ -o $@

# Build Test executables
$(TEST_BINS): $(BIN_DIR)/%: $(BUILD_DIR)/$(TEST_DIR)/%.cpp.o $(OBJS_NO_MAIN)
	@mkdir -p $(dir $@)
	$(CXX) $(LDFLAGS) $^ -o $@ $(LIBS)


.PHONY: all run test clean install_gtest install_doxygen


all: $(EXEC_BIN) $(TEST_BINS)
	
run: $(EXEC_BIN)
	./$(EXEC_BIN)

test: $(TEST_BINS)
	@for test_bin in $(TEST_BINS); do \
		echo "Running $$test_bin..."; \
		./$$test_bin --gtest_output="xml:report.xml"; \
	done

clean:
	rm -r $(BUILD_DIR) $(BIN_DIR) $(EXEC_BIN)


install_gtest:
	apt-get install -y libgtest-dev cmake
	cd /usr/src/gtest && cmake CMakeLists.txt && make && cp lib/*.a /usr/lib

install_doxygen:
	apt-get install -y doxygen graphviz


-include $(DEPS)
