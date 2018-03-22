all: clean compile sim

RTL=	Scheduler_BFM.sv	\
			Controller_FSM.sv	\
			ControllerIF.sv		\
			Controller_tb.sv	\
			DDR4Interface.sv	\
			FSM_wrapper.sv		\
			Memory.sv					\
			ShiftReg.sv				\
			Timer.sv					\
			ReadWrite.sv
			
TOP=	controller_tb

run: work compile sim

work:
	vlib work
compile:
	vlog -source ${RTL} +define+VERBOSE
sim:
	vsim -c ${TOP} -do "run -all;"
clean:
	rm -rf work transcript vsim.wlf




			
	
	
	
	
	
	
	
	
	

