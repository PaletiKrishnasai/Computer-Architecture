`include "WALLACE/FullAdder/64BitAdder.v"

module three_fa(sum,ca,a);
input [8:0][64:0]a;
output [2:0][64:0]sum,ca;

sixtyBitAdder a_0(a[0],a[1],a[2],sum[0],ca[0]);
sixtyBitAdder a_1(a[3],a[4],a[5],sum[1],ca[1]);
sixtyBitAdder a_2(a[6],a[7],a[8],sum[2],ca[2]);


endmodule
