`include "rdcla.v"


module Split(input [31:0]A, output sign, output [7:0]exp, output [22:0]man); // partitioning the 32 bits 
    assign sign = A[31];
    assign exp = A [30:23];
    assign man = A[22:0];
endmodule

module CheckSwap(input [31:0]in1, input [31:0]in2, output reg [31:0]out1, output reg [31:0]out2); // step 1 of algorithm 

    always @(in1 | in2)
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

module Shift(input [31:0]A, input [7:0]shift, output [31:0]B);
    assign B = A>>shift;
endmodule

module RightShift (input [31:0]A, input [7:0]shift, output [31:0]B);
    genvar i;
    generate
    for (i = 0; i < 8'b11111111 ; i = i + 1) 
    begin

        wire [31:0]tmp;
        
        if(i <= 5'b11111)
            assign tmp = A[31:i];
        else 
            assign tmp = 32'b0;

        assign enable = ~|(shift ^ i);

        assign B[31:0] = enable ? tmp[31:0] : 32'bz;

    end
    endgenerate
endmodule

module BarrelShift (input [31:0]A, input [4:0]shift, output [31:0]B);
    genvar i;
    generate
    for (i = 0; i < 5'b11111 ; i = i + 1) 
    begin 

        wire [31:0]tmp;
        
        assign tmp = {A[i:0],A[31:i]};

        assign enable = ~|(shift ^ i);

        assign B[31:0] = enable ? tmp[31:0] : 32'bz;

    end
    endgenerate
endmodule

module top;

    reg [31:0] I1,I2;
    wire [31:0]A,B;
    CheckSwap CS(I1,I2,A,B);


    wire S1,S2;
    wire [7:0] E1,E2;
    wire [22:0] M1,M2;

    Split SP1(A,S1,E1,M1);
    Split SP2(B,S2,E2,M2);

    wire  [7:0]E_Difference;
    assign E_Difference = E1 - E2;

    wire [31:0] N1,N2,N3;
    assign N1 = {|E1,M1};   //Reduction OR handles zeroes
    assign N2 = {|E2,M2};   //and denormal numbers ... we just do the manual normalization.

    RightShift RS(N2,E_Difference,N3);  // makes sure exponents are of the same value.

    wire [31:0]N4;
    assign N4 = {32{S1^S2}}^N3; // 1's complement of second number

    wire [31:0]Sum;
    wire Carry;
    RecursiveDoubling C1(N1,N4,S1^S2,Sum,Carry); // S1^S2 for 2s complement.

    reg [22:0] M3,temp;
    reg [7:0] E3;

    integer i =0;  // to use in always block.

    always @(Sum) // normalizing and adjusting , step 6 .
    begin
        if(Sum[24]==1)
        begin
            M3 = Sum[23:1];
            E3 = E1 + 1'b1;
        end
        else if(Sum[23]==0)
        begin
            i = 1;
            while(Sum[23-i] == 1'b0)
            begin
                i = i+1;
            end 
            E3 = E1 - i;
            temp = Sum[22:0];
            M3 = temp<<i;
        end
        else
        begin
            M3 = Sum[22:0];
            E3 = E1;
        end
    end

    reg [31:0]out;
    always @ (E3 or M3)
    begin

        
        if(&E1 == 1'b1 && |M1 == 1'b0)// Case for infinity
            out = {S1,{8{1'b1}},23'b0};
         
        else 
            out = {S1,{8{|Sum}} & E3,M3};//Handles normal + NaN
    end

    initial
    begin
        #0 I1={1'b0,{8{1'b1}},23'b0}; I2={1'b0,{7{1'b1}},24'b111011}; // inf + normal
        #10 I1={31'b0,1'b1}; I2=32'b00111111110010100011110101110001; // denormal + normal 
        #20 I1=32'b01000110000111000100000000000000;I2=32'b11000101111110100000000000000000; // normal + normal

        #30 I1=32'b11000101111110100000000000000000;I2=32'b01000101111110100000000000000000; // neg + pos = 0 // -0 or +0 depends on I1
        #40 I1=32'b11000000000100000000000000000000;I2=32'b01000000000100000000000000000000;
        #50 I1=32'b01000000000100000000000000000000;I2=32'b00111111101000000000000000000000;
    end
    initial
    begin
        $monitor($time, " Input1=%b Input2=%b\tOUTPUT=%b\t\n",I1,I2,out);
    end

endmodule
