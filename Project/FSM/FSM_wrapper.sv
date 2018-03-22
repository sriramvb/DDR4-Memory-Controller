`include "verifdefs.sv"
module FSM_wrapper
(
	interface cif,interface DDR4Bus,
	input clock,clock2x,reset
);

logic [`DATAWIDTH-1:0] dataread;
logic buff;
logic [`TWIDTH-1:0] tagreadout; 

assign cif.tagfsm = tagreadout;

MemContFSM F ( 	.start(cif.start), 
								.rw(cif.rw_out), 
								.refresh(cif.refresh), 
								.ap(cif.ap),
								.bank(cif.bank),
								.bankgroup(cif.bankgroup),
								.row(cif.row),
								.column(cif.column),
								.datawrite(cif.DataOut), 
								.dataread, 
								.buff,
								.tagreadin(cif.tagread),
								.tagreadout,
								.DDR4Bus(DDR4Bus),
								.reset,.clock,.clock2x,
								.done(cif.done),
								.PageHit(cif.PageHit),
								.PageEmpty(cif.PageEmpty),
								.PageMiss(cif.PageMiss)
 	    	);

endmodule
