`include "getval.v"
`include "bs.v"
`include "barrel.v"

module fpa(
    input [32:1] a,
    input [32:1] b,
    output reg [32:1] c
    );
output wire [32:1] man_a;                                       //to store mantissa value of a
output wire [32:1] man_b;                                       //to store mantissa value of b
wire [32:1] sum;                                                //to store sum of mantissa 
wire [8:1] exp_a,exp_b,dif;                                     //to store exp value of a,b and to store difference of exp of a exp of b
wire [32:1] man_bs;                                             //to store shifted mantissa value of b
wire sign_a,sign_b;                                             //to store sign value of a and b
reg sign_c;                                                     //to store sign value of c
reg [8:1] exp_c;                                                //to store exp value of c
reg [32:1] man_c;                                               //to store mantissa value of c
integer i;

getval m0(a,b,man_a,man_b,exp_a,exp_b,sign_a,sign_b);           //module gets two numbers as input and stores the mantissa ,exp and sign of resp nos 
getdif m1(exp_a,exp_b,dif);                                     // module gets difference between exp of a and b

bs_right m2(man_b,dif,1'b1,1'b0,man_bs);
comparator m3(man_a,man_bs,sign_a,sign_b,sum);                  //module stores sum of mantissa of a and b according to the sign of a and b
always@(*)
begin
    sign_c=sign_a;
    exp_c=exp_a;
    man_c=sum;
    if(a[31:1]==b[31:1] && sign_a!=sign_b)                      //checks whether both numbers are equal and of oppposite sign
begin
sign_c=1'b0;
exp_c=8'b0;
man_c[24]=1'b1;
end

i=32;
while(man_c[i]==0)                                              //find the difference to be shifted to normalize again incase of denormalized sum
i=i-1;

if(i>24)
begin
if(man_a==32'h0080_0000 && man_b==32'h0080_0000)                // incase of sum of mantissa being 0
i=0;
else
i=i-24;
if((a[31:24]==8'd0 && a[23:1]!=0) || (b[31:24]==8'd0 && b[23:1]!=0))  
begin
man_c=man_c;
if(sum>=32'h0180_0000)                                          //subnormal sum check
i=i+1;
end
else
man_c=man_c>>i;
exp_c=exp_c+i;
end
else
begin
i=24-i;
man_c=man_c<<i;
exp_c=exp_c-i;
end

if((a[31:24]==8'hff && a[23:1]!=23'b0) || (b[31:24]==8'hff && b[23:1]!=23'b0)) //to handle nan cases
begin
exp_c=8'hff;
man_c=32'd1;
end
else if(a[31:24]==8'hff ||b[31:24]==8'hff )                                     // to handle inf cases
begin
    exp_c=8'hff;
    man_c=32'd0;
end

//store the result 
c[32]=sign_c;
c[31:24]=exp_c;
c[23:1]=man_c[23:1];

end


endmodule

//Test Module 
module top;
reg [32:1] a,b;
wire [32:1] c;
fpa f1(a,b,c);
initial
begin

    #0 a=32'b01000010000011001010100011110110; b=32'b11000101011000000011111110111110;      //3587.984 + 35.165
    //Special cases
    //adding two inf
    #5 a=32'b01111111100000000000000000000000;   b=32'b01111111100000000000000000000000;    //inf +inf
    //adding nan
    #10 a=32'b01111111111111111111111111111111;    b=32'b01111111111111111110001111111111;  //naN +nan
    //adding zero
    #15 a=32'b00000000000000000000000000000000;    b=32'b10000000000000000000000000000000;  //zero - zero


end
initial
begin

    $monitor("Input :\n\tA=%b\tB=%b\nOutput :\n\tC=%b\n",a,b,c);
    $dumpfile("fpa.vcd");
	$dumpvars;

end
endmodule
