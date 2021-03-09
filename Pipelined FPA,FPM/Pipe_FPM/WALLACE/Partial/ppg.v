

module ppg(c,a,b);
input[31:0] a,b;
output reg[31:0][64:0] c;
output reg [64:0] pp;

integer i,j;

always@(*)
begin





for(i=0;i<32;i+=1)
begin
pp=65'h0000_0000_0000_0000;
for(j=0;j<32;j+=1)
begin

pp[j+i]= a[j] & b[i];


end


c[i]=pp;


end


end
endmodule





