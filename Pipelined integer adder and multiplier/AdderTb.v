`include "Adder.v"
module top;

reg [32:1] a,b;
reg cin;
wire [32:1] sum;
wire cout;
reg clk;
integer i;
initial
begin
    #0 clk = 0;
    for(i=0;i<100;i++)
        #5 clk = ~clk;    
end

CLA rd(clk,sum,cout,a,b,cin);

initial
begin
    #0 a=32'b0; b=32'b0; cin = 1'b0;
   #10 a=32'b11111000111000111000111000111000;
   #20 a=32'b11; b=32'b10 ;
end
initial
begin
    $monitor($time,"\ta = %d , b = %d , cin = %d , cout = %d , sum = %d",a,b,cin,cout,sum);
    $dumpfile("rd.vcd");
    $dumpvars;
end

endmodule