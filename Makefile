BUILD_DIR = ebin

objects = Nand
test_objects = Nand_tests

vpath %_tests.erl tests/simple
vpath %.erl src/simple
vpath %.beam $(BUILD_DIR)

.PHONY: all compile clean test build_dir
all: compile test

compile: build_dir
compile: $(objects)

build_dir:
	mkdir -p $(BUILD_DIR)

clean:
	rm -rf $(BUILD_DIR)

test: $(test_objects)
	erl -noshell -pa $(BUILD_DIR) -eval \
		'eunit:test([{dir, "./$(BUILD_DIR)"}], [verbose])' -s init stop

.PHONY: $(objects) $(test_objects)
$(objects) $(test_objects): %: %.beam

%.beam: %.erl
	erlc -o $(BUILD_DIR)/ $?
