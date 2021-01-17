`include "WallaceTreeMul.v"
`include "Shifters.v"
`include "Tristate.v"

module Split(input [31:0]A, output sign, output [7:0]exp, output [22:0]man); // partitioning the 32 bits 
    assign sign = A[31];
    assign exp = A [30:23];
    assign man = A[22:0];
endmodule

module CheckSwap(input [31:0]in1, input [31:0]in2, output reg [31:0]out1, output reg [31:0]out2); // step 1 of algorithm 

    always @*
    begin
        if(in2[30:0]>in1[30:0])
        begin
            out2 = in1;
            out1 = in2;
        end
        else
        begin
            out1 = in1;
            out2 = in2;
        end
    end

endmodule

module ced39;

reg [31:0] I1,I2;
wire [31:0] out;
wire [31:0]A,B;
CheckSwap CS(I1,I2,A,B);

wire S1,S2;
wire [7:0] E1,E2;
wire [22:0] M1,M2;
Split SP1(A,S1,E1,M1);
Split SP2(B,S2,E2,M2);

// Add the Exponents
wire [31:0]Edenormal,Eout ;
wire Carr;
RecursiveDoubling CLA1({24'b0,E1},{24'b0,E2},1'b0,Edenormal,Carr);
RecursiveDoubling CLA2(Edenormal,~(32'd127),1'b1,Eout,Carr);

wire [31:0]N1,N2;
wire [63:0]P;
assign N1 = {|E1,M1};
assign N2 = {|E2,M2};

WallaceTreeMul WTM(N1,N2,P); //p will be 64 bits

Tristate T1(A,&E1 & |B[30:0],out); // A= inf or NAN and B!=0
Tristate T2(B,~(|B[30:0]) & ~&E1,out); // B =0 and A!=inf or NAN 
Tristate T3({32{1'b1}},&E1 & ~(|B[30:0]),out); // A= inf or NAN and B=0

//Case of overflow
    wire [31:0]EoutShift;
    RecursiveDoubling CL3(Eout,32'b1,1'b0,EoutShift,Carr);
    Tristate T4({S1^S2,EoutShift[7:0],P[46:24]},P[47] & ~(&E1 | ~(|B[30:0])),out);
    //Normal Case
    Tristate T5({S1^S2,Eout[7:0],P[45:23]},~P[47] & P[46] & ~(&E1 | ~(|B[30:0])),out);
    //Case of Underflow
    genvar i;
    wire [31:0]shift;
    generate
        for(i=0;i<47;i=i+1)
        begin : LV
            wire prev1;
            wire [31:0]tmpi;
            if(i==0)
                assign prev1 = 1'b0;
            else
            begin
                assign tmpi= i;
                or R(prev1, LV[i-1].prev1, P[46-i]); // either 1 prev or present bit is 1
                Tristate T7(tmpi,~LV[i-1].prev1 & P[46-i],shift);  // shift is how much u need to move it by           
            end
        end
    endgenerate
    wire [31:0]Enew;
    RecursiveDoubling CL4(Eout,~shift,1'b1,Enew,Carr);

    //2 case -ve Enew(underflow) and +ve Enew(overflow/normal)
    wire [31:0] MoutC1,MoutC2;
    RightShift RS1(P[45:14],shift[7:0],MoutC1);
    LeftShift LS1(P[45:14],Eout[7:0],MoutC2);

    //Case 1 can shift without Enegative
    Tristate T6({S1^S2,Enew[7:0],MoutC1[31:9]},~P[47] & ~P[46] & ~&E1 & (|B[30:0]) & ~Enew[31],out);
    //Case 2 shift would make negative
    Tristate T7({S1^S2,8'b0,MoutC2[31:9]},~P[47] & ~P[46] & ~&E1 & (|B[30:0]) & Enew[31],out);
                    // 8'b0 == underflow case 
    initial
    begin
        // case infinity
        #0 I2={1'b0,{8{1'b1}},23'b0}; I1={1'b0,{7{1'b1}},24'b111011};

        // case zero
        #10 I2={32'b0}; I1=32'b00111111110010100011110101110001;

        // case infinity and zero (out = NAN)
        #10 I2={1'b0,{8{1'b1}},23'b0}; I1=32'b0;

        // 10000 - 800
        #10 I1=32'b01000110000111000100000000000000;I2=32'b11000101111110100000000000000000;

        // 800 - 800
        #10 I1=32'b01000101111110100000000000000000;I2=32'b11000101111110100000000000000000;

        //1.234 * 63.201 = (supposed) 0 | 10000101 | 00110111111101011100110 but gets 01000010100110111111101011100101 because of floating point precision error
        #10 I1=32'b00111111100111011111001110110110;I2=32'b01000010011111001100110111010011;

        // 9.75 * 0.5625 = 5.484375    0 | 10000001 | 01011111000000000000000
        #10 I1={1'b0,{8'b10000010},23'b00111000000000000000000}; I2={1'b0,{8'b01111110},23'b00100000000000000000000};

        // denormal
        #20 I1=32'b00000000000000000000000100000001; I2=32'b01000000000000000000000000000000;

        // 2 , 9
       // #40 I1 = 32'b01000000000000000000000000000000; I2 = 32'b01000001000100000000000000000000;
    end
    initial
    begin
        $monitor($time, " I1=%b I2=%b\tOUTPUT=%b\n",I1,I2,out);
   end

    
endmodule