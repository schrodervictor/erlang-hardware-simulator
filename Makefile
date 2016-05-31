DEBUG_FLAG =
BUILD_DIR = ebin
BUILD_TESTS = etests

simple = Nand Not And Or Xor Mux DMux DMux4Way DMux8Way
simple8 = Or8Way
simple16 = And16 Or16 Mux16 Not16 Mux4Way16 Mux8Way16
ALU = HalfAdder FullAdder Add16 Inc16 ALU
clocked = DFF

objects = $(simple) $(simple8) $(simple16) $(ALU) $(clocked)
test_objects = $(addsuffix _tests,$(objects))

vpath %_tests.erl tests/simple:tests/simple8:tests/simple16:tests/ALU:tests/clocked
vpath %.erl src/simple:src/simple8:src/simple16:src/ALU:src/clocked
vpath %.beam $(BUILD_DIR):$(BUILD_TESTS)

.PHONY: all debug compile clean test build_dir
all: compile test

debug: DEBUG_FLAG=+debug_info
debug: compile test
	erl -pa $(BUILD_DIR) -sname bm-config -eval \
		"debugger:start(),'Nand':chip(1, 1)."

compile: build_dir
compile: $(objects)

build_dir:
	mkdir -p $(BUILD_DIR)
	mkdir -p $(BUILD_TESTS)

clean:
	rm -rf $(BUILD_DIR)
	rm -rf $(BUILD_TESTS)

test: $(test_objects)
	erl -noshell -pa $(BUILD_DIR) -eval \
		'eunit:test([{dir, "./$(BUILD_TESTS)"}], [verbose])' -s init stop

.PHONY: $(objects) $(test_objects)
$(objects) $(test_objects): %: %.beam

%_tests.beam: %_tests.erl
	erlc $(DEBUG_FLAG) -o $(BUILD_TESTS)/ $?

%.beam: %.erl
	erlc $(DEBUG_FLAG) -o $(BUILD_DIR)/ $?
