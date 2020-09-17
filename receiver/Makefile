all: sim sint

#sim: receiver_tb.vcd

sint: receiver.bin

#receiver_tb.vcd: receiver.v receiver_tb.v
#	iverilog -o receiver_tb.out receiver.v receiver_tb.v
#	./receiver_tb.out
#	gtkwave receiver_tb.vcd receiver_tb.gtkw &

receiver.bin: receiver.v receiver.pcf
	#yosys -p "synth_ice40 -blif receiver.blif" receiver.v
	yosys -p 'synth_ice40 -top receiver -json receiver.json' receiver.v signal.v toolkit.v

	#arachne-pnr -d 8k -P tq144:4k -p receiver.pcf receiver.blif -o receiver.txt
	nextpnr-ice40 --hx8k --package tq144:4k --json receiver.json --pcf receiver.pcf --asc receiver.asc

	#icepack receiver.txt receiver.bin
	icepack receiver.asc receiver.bin

flash:
	iceprog -d i:0x0403:0x6010:0 receiver.bin

clean:
	rm -f *.bin *.asc *.json *.out *.vcd *~

.PHONY: all clean
