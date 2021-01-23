// INPUTS:-
// ReadRegister1: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister1'.
// ReadRegister2: 5-Bit address to select a register to be read through 32-Bit 
//                output port 'ReadRegister2'.
// WriteRegister: 5-Bit address to select a register to be written through 32-Bit
//                input port 'WriteRegister'.
// WriteData: 32-Bit write input port.
// RegWrite: 1-Bit control input signal.
//
// OUTPUTS:-
// ReadData1: 32-Bit registered output. 
// ReadData2: 32-Bit registered output. 
//
// FUNCTIONALITY:-
// 'ReadRegister1' and 'ReadRegister2' are two 5-bit addresses to read two 
// registers simultaneously. The two 32-bit data sets are available on ports 
// 'ReadData1' and 'ReadData2', respectively. 'ReadData1' and 'ReadData2' are 
// registered outputs (output of register file is written into these registers 
// at the falling edge of the clock). You can view it as if outputs of registers
// specified by ReadRegister1 and ReadRegister2 are written into output 
// registers ReadData1 and ReadData2 at the falling edge of the clock. 
//
// 'RegWrite' signal is high during the rising edge of the clock if the input 
// data is to be written into the register file. The contents of the register 
// specified by address 'WriteRegister' in the register file are modified at the 
// rising edge of the clock if 'RegWrite' signal is high. The D-flip flops in 
// the register file are positive-edge (rising-edge) triggered. (You have to use 
// this information to generate the write-clock properly.) 



module RegisterFile(ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite, Clk, ReadData1, ReadData2);

	input [4:0] ReadRegister1,ReadRegister2,WriteRegister;
	input [31:0] WriteData;
	input RegWrite,Clk;
	
	output reg [31:0] ReadData1,ReadData2;
	
	
	reg [31:0] Registers [0:31];
	
	initial 
	 begin
		// $display("init");
		Registers[0] <= 32'd23;
		Registers[8] <= 32'd26;
		Registers[9] <= 32'd35;
		Registers[10] <= 32'd95;
		Registers[11] <= 32'd65;
		Registers[12] <= 32'd78;
		Registers[13] <= 32'd14;
		Registers[14] <= 32'd38;
		Registers[15] <= 32'd74;
		Registers[16] <= 32'd21;
		Registers[17] <= 32'd49;
		Registers[18] <= 32'd50;
		Registers[19] <= 32'd13;
		Registers[20] <= 32'd18;
		Registers[21] <= 32'd24;
		Registers[22] <= 32'd63;
		Registers[23] <= 32'd81;
		Registers[24] <= 32'd99;
		Registers[25] <= 32'd96;
		Registers[29] <= 32'd252;
		Registers[31] <= 32'b0;
	end
	
	
	always @(posedge Clk)
	begin
		
		if (RegWrite == 1) 
		begin
			Registers[WriteRegister] <= WriteData;
		end
	end
	
	always @(negedge Clk)
	begin
		//$display("run");
		ReadData1 <= Registers[ReadRegister1];
		ReadData2 <= Registers[ReadRegister2];
	end
	
	

endmodule

module top;

	reg [4:0] ReadRegister1,ReadRegister2,WriteRegister;
	reg [31:0] WriteData;
	reg RegWrite=1,Clk;
	wire [31:0] ReadData1,ReadData2;
	RegisterFile RF1(ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite, Clk, ReadData1, ReadData2);
	initial  
	begin
		#0 Clk = 1;
		#10 Clk = 0;
		#10 Clk = 1;
		#10 Clk = 0;
		#10 Clk = 1;
		#10 Clk = 0;
		#10 Clk = 1;
		#10 Clk = 0;

	end
	initial begin
		WriteData = 32'd525;
		ReadRegister1 = 5'd8;
		ReadRegister2 = 5'd9;
		WriteRegister = 5'd10;
		#30 ReadRegister1 = 5'd10; ReadRegister2 = 5'd9;
	end
	initial begin
		$monitor($time, "ALU Input1=%d ALU Input2=%d CLK=%d \n",ReadData1,ReadData2,Clk);

	end



endmodule
