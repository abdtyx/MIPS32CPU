MAIN = testbench
BUILD = build
SRC = src

all: v vvp

v: $(SRC)/*.v
	iverilog -o $(BUILD)/$(MAIN).vvp -I $(SRC) $^

vvp:
	cd $(BUILD) && vvp $(MAIN).vvp

clean:
	rm -rf *.vcd *.vvp