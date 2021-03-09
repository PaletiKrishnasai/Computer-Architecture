`include "kpg.v"
`include "ppc1.v"
module adder(si,xout,a,b,xin);

input [63:0] a,b;
input[7:0] xin;
output [64:0][7:0]x;
integer i=0;

output reg[7:0] ym;

output [7:0]xout;
  output [63:0][7:0] y ;
  output reg[63:0] si;
  
kpgg kpg_0(x[8:1],a[7:0],b[7:0]);
kpgg kpg_1(x[16:9],a[15:8],b[15:8]);
kpgg kpg_2(x[24:17],a[23:16],b[23:16]);
kpgg kpg_3(x[32:25],a[31:24],b[31:24]);

kpgg kpg_4(x[40:33],a[39:32],b[39:32]);
kpgg kpg_5(x[48:41],a[47:40],b[47:40]);
kpgg kpg_6(x[56:49],a[55:48],b[55:48]);
kpgg kpg_7(x[64:57],a[63:56],b[63:56]);

assign x[0]=xin;

ppc ppc_0(y[63:0],x[63:0]);

always@(*)
begin
if(x[64]=="p")
begin
if(y[63]=="g")
ym="g";
else
ym="k";
end
else
ym=x[64];
for(i=0;i<64;i=i+1)
begin
if(y[i]=="k")
si[i]=(a[i]^b[i])^0;
else
si[i]=(a[i]^b[i])^1;
end
end

assign xout=ym;

endmodule
