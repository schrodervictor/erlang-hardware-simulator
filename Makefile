BUILD_DIR = ebin
BUILD_TESTS = etests

simple = Nand Not And Or Xor Mux DMux DMux4Way DMux8Way
simple8 = Or8Way
objects = $(simple) $(simple8)
test_objects = $(addsuffix _tests,$(objects))

vpath %_tests.erl tests/simple:tests/simple8
vpath %.erl src/simple:src/simple8
vpath %.beam $(BUILD_DIR):$(BUILD_TESTS)

.PHONY: all compile clean test build_dir
all: compile test

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
	erlc -o $(BUILD_TESTS)/ $?

%.beam: %.erl
	erlc -o $(BUILD_DIR)/ $?
