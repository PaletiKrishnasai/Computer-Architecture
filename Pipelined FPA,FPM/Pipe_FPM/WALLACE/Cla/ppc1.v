`include "WALLACE/Cla/lvl64.v"
`include "WALLACE/Cla/dff.v"
module ppca(y,x,comb,rst,clk,a,b,c,d,combn);

input [63:0][7:0]x;
input [63:0] a,b;
input [74:1] comb;

wire [63:0][7:0]reg1,reg2,reg3,reg4,reg5,reg6;
wire[63:0] wire6,wire7,wire8,wire9,wire10,wire11,wire12,wire13,wire14,wire15,wire16,wire17;

output  [63:0][7:0] y ;
output [63:0] c,d;
output [74:1] combn;
wire  [63:0][7:0] wire1,wire2,wire3,wire4,wire5,wire18 ;
wire [74:1] comb1,comb2,comb3,comb4,comb5,comb6;


input rst,clk;

dff_lvl c1(x,comb,rst,clk,reg1,wire6,wire7,a,b,comb1); //pipeline-11
lvl m1(wire1,reg1,3'd0);

dff_lvl c2(wire1,comb1,rst,clk,reg2,wire8,wire9,wire6,wire7,comb2); //pipeline-12
lvl m2(wire2,reg2,3'd1);

dff_lvl c3(wire2,comb2,rst,clk,reg3,wire10,wire11,wire8,wire9,comb3); //pipeline-13
lvl m3(wire3,reg3,3'd2);

dff_lvl c4(wire3,comb3,rst,clk,reg4,wire12,wire13,wire10,wire11,comb4); //pipeline-14
lvl m4(wire4,reg4,3'd3);

dff_lvl c5(wire4,comb4,rst,clk,reg5,wire14,wire15,wire12,wire13,comb5); //pipeline-15
lvl m5(wire5,reg5,3'd4);

dff_lvl c6(wire5,comb5,rst,clk,reg6,wire16,wire17,wire14,wire15,comb6); //pipeline-16
lvl m6(wire18,reg6,3'd5);

dff_lvl c7(wire18,comb6,rst,clk,y,c,d,wire16,wire17,combn); //pipeline-17



endmodule
