`include "WALLACE/FullAdder/32BitAdder.v"

module sixtyBitAdder(a,b,cin,sum,ca);
input [64:0] a,b;
input [64:0]cin;

output[64:0] sum;
output [64:0]ca;

assign ca[0]=1'b0;
assign sum[64]=1'b0;

thirtBitAdder FA_0(a[31:0],b[31:0],cin[31:0],sum[31:0],ca[32:1]);
thirtBitAdder FA_1(a[63:32],b[63:32],cin[63:32],sum[63:32],ca[64:33]);


endmodule
