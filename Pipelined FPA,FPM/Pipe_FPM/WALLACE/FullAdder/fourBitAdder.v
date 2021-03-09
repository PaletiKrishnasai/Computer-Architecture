`include "WALLACE/FullAdder/fullAdder.v"

module fourBitAdder(a,b,cin,sum,ca);
input[3:0] a,b;
input [3:0]cin;

output [3:0] sum;
output [3:0]ca;


fullAdder FA_0(a[0],b[0],cin[0],sum[0],ca[0]);
fullAdder FA_1(a[1],b[1],cin[1],sum[1],ca[1]);
fullAdder FA_2(a[2],b[2],cin[2],sum[2],ca[2]);
fullAdder FA_3(a[3],b[3],cin[3],sum[3],ca[3]);

endmodule
