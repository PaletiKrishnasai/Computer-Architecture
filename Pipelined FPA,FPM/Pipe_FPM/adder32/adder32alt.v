`include "adder32/kpga.v"
`include "adder32/ppc1a.v"
module adder(si,a,b);

input [31:0] a,b;
output [32:0][7:0]x;

integer i=0;

output reg[7:0] ym;

output [7:0]xout;
  output [31:0][7:0] y ;
  output reg[31:0] si;
  
kpgg kpg_0(x[8:1],a[7:0],b[7:0]);
kpgg kpg_1(x[16:9],a[15:8],b[15:8]);
kpgg kpg_2(x[24:17],a[23:16],b[23:16]);
kpgg kpg_3(x[32:25],a[31:24],b[31:24]);

assign x[0]="k";

ppc ppc_0(y[31:0],x[31:0]);

always@(*)
begin
if(x[32]=="p")
begin
if(y[31]=="g")
ym="g";
else
ym="k";
end
else
ym=x[32];
for(i=0;i<32;i=i+1)
begin
if(y[i]=="k")
si[i]=(a[i]^b[i])^0;
else
si[i]=(a[i]^b[i])^1;
end
end

assign xout=ym;

endmodule
