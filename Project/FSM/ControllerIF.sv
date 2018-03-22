`include "verifdefs.sv"
interface ControllerIF(input logic clock,reset);

logic [`BWIDTH-1:0] bank;
logic [`BGWIDTH-1:0] bankgroup;
logic [`RWIDTH-1:0] row;
logic [`CWIDTH-1:0] column;
logic [`DATAWIDTH-1:0] DataIn;
logic [`ADDRESSWIDTH-1:0] AddrIn;
logic rw_in;
logic start,done,valid,buff;
logic [`BUFFBITS-1:0] tagfsm;
logic [`DATAWIDTH-1:0] DataOut;
logic [`ADDRESSWIDTH-1:0] AddrOut;
logic rw_out,full,refresh,ap; 
logic [`BUFFBITS -1:0]tagread, tag;
logic PageMiss, PageEmpty;
logic [1:0] PageHit;

/****************Mapping****************/
assign row = AddrOut [31:17];
assign bank = AddrOut[16:15];
assign column = {AddrOut[14:8],AddrOut[5:3]};
assign bankgroup = AddrOut[7:6];
/***************************************/


modport Sched_FSM 	(
											output 	DataOut,AddrOut,rw_out,refresh,ap,start,tagread,PageMiss,PageEmpty,PageHit,
											input 	done,buff,tagfsm,reset,clock
										);

modport FSM_Sched	(
											
											output 	done,buff,tagfsm,
											input 	DataOut,bank,bankgroup,row,column,rw_out,refresh,ap,start,tagread,PageMiss,PageEmpty,PageHit
										);

modport Sched_Cache	(
											output tag,full,
											input DataIn,AddrIn,rw_in,valid,clock,reset
										);
endinterface
