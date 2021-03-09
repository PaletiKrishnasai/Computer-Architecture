`include "WALLACE/FullAdder/16BitAdder.v"

module thirtBitAdder(a,b,cin,sum,ca);
input[31:0] a,b;
input [31:0]cin;

output[31:0] sum;
output [31:0]ca;



sixtBitAdder FA_0(a[15:0],b[15:0],cin[15:0],sum[15:0],ca[15:0]);
sixtBitAdder FA_1(a[31:16],b[31:16],cin[31:16],sum[31:16],ca[31:16]);


endmodule
