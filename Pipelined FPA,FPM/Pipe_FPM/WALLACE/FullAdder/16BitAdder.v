`include "WALLACE/FullAdder/fourBitAdder.v"

module sixtBitAdder(a,b,cin,sum,ca);
input[15:0] a,b;
input [15:0]cin;

output[15:0] sum;
output [15:0]ca;


fourBitAdder FA_0(a[3:0],b[3:0],cin[3:0],sum[3:0],ca[3:0]);
fourBitAdder FA_1(a[7:4],b[7:4],cin[7:4],sum[7:4],ca[7:4]);
fourBitAdder FA_2(a[11:8],b[11:8],cin[11:8],sum[11:8],ca[11:8]);
fourBitAdder FA_3(a[15:12],b[15:12],cin[15:12],sum[15:12],ca[15:12]);

endmodule
