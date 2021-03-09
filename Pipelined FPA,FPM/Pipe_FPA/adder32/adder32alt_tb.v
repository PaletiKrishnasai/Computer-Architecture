`include "adder32alt.v"

module top;
reg signed [31:0]ai,bi;
reg[7:0] xin;
wire signed [31:0]si;
wire[7:0]xout;
adder adder_0(si,xout,ai,bi,xin);

initial
begin
#0 xin="k"; ai=36865; bi=33023;
#1 xin="k"; ai=9943121; bi=-3302367;
#1 xin="k"; ai=-3686; bi=3023;
end

initial
 begin
 	$monitor(" Input bits:Number-1=%0d and Number-2=%0d;\nOutput: Sum=%0d  Final Input Carry generated=%s\n",ai,bi,si,xout);
 	$dumpfile("adder32alt.vcd");
 	$dumpvars;  
end
endmodule

