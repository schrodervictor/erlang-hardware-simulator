DEBUG_FLAG =
BUILD_DIR = ebin
BUILD_TESTS = etests
INCLUDE_DIR = include

simple = Nand Not And Or Xor Mux DMux DMux4Way DMux8Way
simple8 = Or8Way
simple16 = And16 Or16 Mux16 Not16 Mux4Way16 Mux8Way16
ALU = HalfAdder FullAdder Add16 Inc16 ALU
clocked = DFF Bit Register RAM8 RAM64 RAM512 RAM4K RAM16K
assembler = ATranslator CTranslator LabelParser WhiteSpaceParser Assembler

objects = $(simple) $(simple8) $(simple16) $(ALU) $(clocked) $(assembler)
test_objects = $(addsuffix _tests,$(objects))
include_objects = $(wildcard $(INCLUDE_DIR)/*.hrl)

vpath %_tests.erl $(wildcard tests/*)
vpath %.erl $(wildcard src/*)
vpath %.beam $(BUILD_DIR):$(BUILD_TESTS)

.PHONY: all debug compile clean test build_dir
all: compile test

debug: DEBUG_FLAG=+debug_info
debug: compile test
	erl -pa $(BUILD_DIR) -sname nand2tetris -eval \
		"debugger:start(),'Nand':chip(1, 1)."

compile: build_dir
compile: $(objects)

build_dir:
	mkdir -p $(BUILD_DIR)
	mkdir -p $(BUILD_TESTS)

clean:
	rm -rf $(BUILD_DIR)
	rm -rf $(BUILD_TESTS)

test: TEST = {dir, "./$(BUILD_TESTS)"}
test: $(test_objects)
	erl -noshell -pa $(BUILD_DIR) -eval \
		'eunit:test([$(TEST)], [verbose])' -s init stop

.PHONY: $(objects) $(test_objects)
$(objects) $(test_objects): %: %.beam

%_tests.beam: %_tests.erl $(include_objects)
	erlc $(DEBUG_FLAG) -o $(BUILD_TESTS)/ -I $(INCLUDE_DIR) $<

%.beam: %.erl
	erlc $(DEBUG_FLAG) -o $(BUILD_DIR)/ $?
