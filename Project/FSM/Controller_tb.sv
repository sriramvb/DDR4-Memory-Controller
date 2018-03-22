`include "verifdefs.sv"
module controller_tb();
import verifclass::*;
logic clock,clock2x,reset;
StimulusGen stimulus;

/********Clock Generator************/
//Clock1x Generator
initial begin
clock = 1'b1;
reset = 1'b1;
forever #10 clock = ~clock;
end

//Clock2x Generator
initial begin
clock2x=1'b1;
forever #5 clock2x = ~clock2x;
end


//Instantiate the DDR4Interface
DDR4Interface DDR4Bus (clock,reset);

//Instantiate the DUT
FSM_wrapper dut (cif.FSM_Sched,DDR4Bus.Controller,clock,clock2x,reset);
//Instantiate The Memory BFM
Memory mem (DDR4Bus.Memory,clock2x);

//Instantiate the Scheduler to Controller Interface
ControllerIF cif (clock,reset);


initial begin
	stimulus = new(cif.Sched_FSM);
	repeat(10) @(posedge clock);
	reset=1'b0;
	stimulus.execute();
end

`ifdef VERBOSE
initial
	//$monitor($time,"\tDONE=%b\t START=%b\n",cif.done,cif.start);
	$monitor($time,"\tDataBus:%x",DDR4Bus.pin_dq);
`endif

endmodule

