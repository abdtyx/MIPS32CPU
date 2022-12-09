MAIN = testbench
BUILD = build
SRC = src

all: v vvp

v: $(SRC)/*.v
	mkdir -p $(BUILD)
	iverilog -o $(BUILD)/$(MAIN).vvp -I $(SRC) $^

vvp:
	cd $(BUILD) && vvp $(MAIN).vvp

clean:
	rm -rf $(BUILD)