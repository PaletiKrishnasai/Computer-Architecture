`include "WALLACE/FullAdder/3fa.v"

module three_fam(sum,ca,s,c);
input [4:0][64:0]s;
input [3:0][64:0]c;

output  [2:0][64:0]sum,ca;


sixtyBitAdder a_0(s[0],s[1],c[0],sum[0],ca[0]);
sixtyBitAdder a_1(c[1],s[2],c[2],sum[1],ca[1]);
sixtyBitAdder a_2(s[3],s[4],c[3],sum[2],ca[2]);


endmodule
