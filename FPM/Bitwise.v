module Bitwise (A,B,p);

input [32:1] A; // multiplicand
input B; // multiplier bit
output [32:1] p ; //partial product

assign p[1] = A[1] & B;
assign p[2] = A[2] & B;
assign p[3] = A[3] & B;
assign p[4] = A[4] & B;
assign p[5] = A[5] & B;
assign p[6] = A[6] & B;
assign p[7] = A[7] & B;
assign p[8] = A[8] & B;
assign p[9] = A[9] & B;
assign p[10] = A[10] & B;
assign p[11] = A[11] & B;
assign p[12] = A[12] & B;
assign p[13] = A[13] & B;
assign p[14] = A[14] & B;
assign p[15] = A[15] & B;
assign p[16] = A[16] & B;
assign p[17] = A[17] & B;
assign p[18] = A[18] & B;
assign p[19] = A[19] & B;
assign p[20] = A[20] & B;
assign p[21] = A[21] & B;
assign p[22] = A[22] & B;
assign p[23] = A[23] & B;
assign p[24] = A[24] & B;
assign p[25] = A[25] & B;
assign p[26] = A[26] & B;
assign p[27] = A[27] & B;
assign p[28] = A[28] & B;
assign p[29] = A[29] & B;
assign p[30] = A[30] & B;
assign p[31] = A[31] & B;
assign p[32] = A[32] & B;
endmodule