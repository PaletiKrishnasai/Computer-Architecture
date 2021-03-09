module lvl(y,x,k);

input [63:0][7:0]x;

output reg [63:0][7:0] y ;

input [2:0] k;

integer i=0,j=0;


always@(*)
begin//always begin

j<=k;

for(i=0;i<64;i=i+1)
begin
y[i]=x[i];
end//for loop end


for(i=63;(i-2**j)>=0;i=i-1)
begin//for begin
if(y[i]=="k")//case 1
begin
y[i]="k";

end//if end
else if(y[i]=="p") //case 2
begin
if(y[i-2**j]=="k")
y[i]="k";
else if(y[i-2**j]=="p")
y[i]="p";
else
y[i]="g";
end
else //case 3
begin
y[i]="g";
end//else end
end//for end


end//always end
endmodule