TARGET = testbench

all: src vvp

src:
	iverilog $(TARGET).v -o $(TARGET).vvp

vvp:
	vvp $(TARGET).vvp

clean:
	rm -rf *.vcd *.vvp