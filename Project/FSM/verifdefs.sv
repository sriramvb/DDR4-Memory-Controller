`ifndef __VERIFDEFS__
`define __VERIFDEFS__

	`define TRP 		 				16
	`define TRCD 						16
	`define TCL 	 					16
	`define TCCD_L  				6
	`define TCCD_S  				4
	`define CWIDTH  				10
	`define RWIDTH  				15
	`define BWIDTH  				2
	`define BGWIDTH 				2
	`define TWIDTH  				3
	`define DATAWIDTH 			512 
	`define ADDRESSWIDTH  	32
	`define AWIDTH  				18
	`define DWIDTH  				64
	`define BANKGROUP   		4
	`define BANKS 	 				4
	`define B_BITS  				2 				//$clog2(BANKS),	
	`define BG_BITS	  			2					//$clog2(BANKGROUP),	
	`define SHIFTBITS 	 		4					//$clog2(TCL),
	`define ROW							32768 		//2**RWIDTH
	`define COL							1024			//2**CWIDTH
	`define BUFFLENGTH  		8
	`define BUFFBITS  			3					//$clog2(BuffLength),
	`define THRESHOLD  			16'h1000

`endif
