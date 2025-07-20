cd\
cd C:\Users\Anand\Downloads\Project_COA
del processor.vvp
del wave.vcd



C:\iverilog\bin\iverilog -g2012 -Wall -o processor.vvp processor.v Riscprocessor_tb.v
PAUSE
C:\iverilog\bin\vvp processor.vvp
dir
PAUSE
C:\iverilog\gtkwave\bin\gtkwave -f wave.vcd
PAUSE