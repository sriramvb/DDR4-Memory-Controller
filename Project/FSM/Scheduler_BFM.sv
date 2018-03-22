package verifclass;
`include "verifdefs.sv"
class input_rand;

	rand logic [`BWIDTH-1:0] bank;
	rand logic [`BGWIDTH-1:0] bankgroup;
	rand logic [`RWIDTH-1:0] row;
	rand logic [`CWIDTH-1:0] column;
	rand logic [1:0] PageHit;
	rand logic PageMiss,PageEmpty;
	
	
	constraint bank_constraint	{
																bank inside {[0:`BANKS]};
															}
	
	
	constraint bankgrp_constraint	{
																	bank inside {[0:`BANKGROUP]};
																}
	
	constraint row_constraint			{
																	row inside {[0:`ROW]};
																}
	
	constraint col_constraint			{
																	row inside {[0:`COL]};
																}
																
endclass


class StimulusGen;
	virtual ControllerIF cif;
	input_rand inputs;
	
	function new( virtual ControllerIF inf); 
		cif=inf;
		inputs = new();
	endfunction

	task delay (int n);
		repeat (n) @(posedge cif.clock);
	endtask
	
	task request_gen(
										logic rw,refresh,
										logic [`BWIDTH-1:0] bank,
										logic [`BGWIDTH-1:0] bankgroup,
                    logic [`RWIDTH-1:0] row,
                    logic [`CWIDTH-1:0] column,
                    logic [1:0] PageHit,
                    logic PageMiss,PageEmpty
									);
		cif.AddrOut = {row,bank,column[`CWIDTH-1:3],bankgroup,column[2:0]};
		cif.rw_out = rw; 
		if (!rw)
			cif.DataOut = $urandom_range(100);
    cif.tagread = $urandom_range(0,7);
    {cif.PageMiss,cif.PageEmpty,cif.PageHit} = {PageMiss,PageEmpty,PageHit};
    cif.start = 1'b1;
    cif.refresh = refresh;
    delay(2);
    cif.start=1'b0;

	endtask
	
	task execute;
		logic [`RWIDTH-1:0] row_const;
		logic [`BWIDTH-1:0] bank_const;
		logic [`BGWIDTH-1:0] bankgroup_const;
		//Initially make requests to all the banks and bankgroups with Page Empty
		for (int i=0;i<`BANKGROUP;i++) begin
			for (int j=0;j<`BANKS;j++) begin
				assert(inputs.randomize())
					else $fatal("Failed to randomize the inputs");
				request_gen(1'b0,1'b0,j,i,inputs.row,inputs.column,2'd0,1'b0,1'b1);
				`ifdef VERBOSE
					$display($time,"\tRequest Issued to Address:%x\t DONE=%b\n",{cif.AddrOut[31:6],6'b0},cif.done);
				`endif
				wait (cif.done);
				delay(1);
			end
		end //End initial access
	$display("Test2\n")	;
		//Make requests with Page Hits
		row_const=inputs.row;
		repeat(10) begin
			assert(inputs.randomize())
				else $fatal("Failed to randomize the inputs");
			request_gen(1'b0,1'b0,inputs.bank,inputs.bankgroup,row_const,inputs.column,2'd2,1'd0,1'd0);
		end
		$display("Test3\n")	;
		//Make requests with Page Hits
		row_const=inputs.row;
		bank_const=inputs.bank;
		bankgroup_const=inputs.bankgroup;
		repeat(10) begin
			assert(inputs.randomize())
				else $fatal("Failed to randomize the inputs");
			request_gen(1'b0,1'b0,bank_const,bankgroup_const,row_const,inputs.column,2'd2,1'd0,1'd0);
		end
			

		delay(2000);

		$finish;
	endtask
		

endclass
endpackage
