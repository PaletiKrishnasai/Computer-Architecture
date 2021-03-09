`include "getval.v"
`include "bs.v"
`include "WALLACE/32wallace.v"
`include "dff_lvla.v"

module fpm(
    input [32:1] a,
    input [32:1] b,
    input clk,
    input rst,
    output  [32:1] c
    );
output wire [33:1] man_a,man_a2;                                                   //to store mantissa value of a
output wire [33:1] man_b,man_b2;                                                   //to store mantissa value of b
 
wire [8:1] exp_a,exp_b,exp_a2,exp_b2;                                                     //to store exp value of a,b and to store difference of exp of a exp of b

wire [32:1] a1,b1,a2,b2,a3,b3;      

wire sign_a,sign_b,sign_a2,sign_b2;                                                         //to store sign value of a and b
reg sign_c;
wire sign_c3;                                                                 //to store sign value of c
reg [9:1] exp_c;
wire [9:1] exp_c3;                                                            //to store product of a mantissa of a and b
wire [9:1] exp_cs;
wire [9:1] exp_cs2;
wire [65:1] man_c;                                                          //to store mantissa value of c
wire [65:1] man_cs;
assign man_a[33]=1'b0;
assign man_b[33]=1'b0;

integer i;

dff_lvl_p1 p1(a,b,rst,clk,a1,b1);
getval m0(a1,b1,man_a[32:1],man_b[32:1],exp_a,exp_b,sign_a,sign_b);           //module gets two numbers as input and stores the mantissa ,exp and sign of resp nos 

dff_lvl_p2 p2(a1,b1,man_a,man_b,exp_a,exp_b,sign_a,sign_b,rst,clk,a2,b2,man_a2,man_b2,exp_a2,exp_b2,sign_a2,sign_b2);

always@(posedge clk)
begin
    sign_c=sign_a2^sign_b2;
    exp_c=exp_a2+exp_b2-127;
end

wallace m1(man_c,man_a2,man_b2,a2,b2,exp_c,sign_c,clk,rst ,a3,b3,exp_c3,sign_c3 );                                              //module multiplies mantissa of a and b

    //ai,bi
    mux22 m2(man_c[48],exp_c3,exp_cs);                                       //increment exp if 48th bit is set to 1
    mux21 m3(exp_cs,a3,b3,exp_cs2);                                           //if exponent is greater than 255 or 255 ,exp will be set to 255
    mux23 m4(man_c,a3,b3,man_cs);                                             //to handle special cases like nan or infinity (mantissa)
    mux24 m5(man_c[48],man_cs,exp_cs2,a3,b3,c);                               //to handle a special case where either of the input is zero


assign c[32]=sign_c3;


endmodule


module top;
reg [32:1] a,b;
reg clk,rst;
wire [32:1] c;
integer i;
fpm f1(a,b,clk,rst,c);
initial
begin

    #0 a=32'b01000001011111111111111111111111;   b=32'b01000001010000010000000000000000;      
    //Special cases
    //adding two inf
    #5 a=32'b01111111000000000000000000000000;   b=32'b01111111000000000000000000000000;    //inf *inf
    //adding nan
    //#10 a=32'b01111111111111111111111111111111;  b=32'b01111111111111111110001111111111;  //naN *nan
    //adding zero
    //#15 a=32'b00000000000000000000000000000000;  b=32'b10000000000000000000000000000000;  //zero - zero

    //#20 a=32'b01000010111110100100000000000000;  b=32'b11000001010000010000000000000000; 


end
initial
begin
clk=1;
rst=0;
rst=1;
for (i=0;i<60;i++)
#1 clk=~clk;
end
initial
begin

    $monitor("Time:",$time,"\nInput  :A=%b\tB=%b\nOutput :\tC=%b\n",a,b,c);
    $dumpfile("fpm.vcd");
	$dumpvars;

end
endmodule
