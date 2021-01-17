`include "HalfAdder.v"
`include "Bitwise.v"
`include "CSA.v"
`include "multiplier.v"
`include "rdcla.v"

module WallaceTreeMul (A,B,C);

 input [31:0] A, B;
 output [63:0] C;
 wire cout;
 wire cout1;


    wire [63:0] AB [31:0], temp1 [31:0];
    wire [31:0] temp [31:0];
    wire [63:0] s [30:0];
    wire [63:0] c [30:0];
    wire K;
    genvar i;
    generate
        for(i = 0; i < 32; i = i + 1)
        begin : and_loop
            multiplier mul(A, B[i], temp[i]);
            assign temp1[i] = {{32{1'b0}}, temp[i]};
            assign AB[i] = temp1[i] << i;
        end
    endgenerate

    CSA ca01(AB[0], AB[1], AB[2], s[0], c[0]);
    CSA ca02(AB[3], AB[4], AB[5], s[1], c[1]);
    CSA ca03(AB[6], AB[7], AB[8], s[2], c[2]);
    CSA ca04(AB[9], AB[10], AB[11], s[3], c[3]);
    CSA ca05(AB[12], AB[13], AB[14], s[4], c[4]);
    CSA ca06(AB[15], AB[16], AB[17], s[5], c[5]);
    CSA ca07(AB[18], AB[19], AB[20], s[6], c[6]);
    CSA ca08(AB[21], AB[22], AB[23], s[7], c[7]);
    CSA ca09(AB[24], AB[25], AB[26], s[8], c[8]);
    CSA ca10(AB[27], AB[28], AB[29], s[9], c[9]);
    CSA ca11(s[0], c[0], s[1], s[10], c[10]);
    CSA ca12(c[1], s[2], c[2], s[11], c[11]);
    CSA ca13(c[3], s[3], s[4], s[12], c[12]);
    CSA ca14(c[4], s[5], c[5], s[13], c[13]);
    CSA ca15(s[6], c[6], s[7], s[14], c[14]);
    CSA ca16(c[7], c[8], s[8], s[15], c[15]);
    CSA ca17(s[9], c[9], AB[30], s[16], c[16]);
    CSA ca18(s[10], c[10], s[11], s[17], c[17]);
    CSA ca19(c[11], s[12], c[12], s[18], c[18]);
    CSA ca20(c[13], s[13], s[14], s[19], c[19]);
    CSA ca21(c[14], c[15], s[15], s[20], c[20]);
    CSA ca22(s[16], c[16], AB[31], s[21], c[21]);
    CSA ca23(s[17], c[17], s[18], s[22], c[22]);
    CSA ca24(c[18], s[19], c[19], s[23], c[23]);
    CSA ca25(c[20], s[20], s[21], s[24], c[24]);
    CSA ca26(s[22], c[22], s[23], s[25], c[25]);
    CSA ca27(c[23], s[24], c[24], s[26], c[26]);
    CSA ca28(c[25], s[25], s[26], s[27], c[27]);
    CSA ca29(c[26], c[21], {64{1'b0}}, s[28], c[28]);
    CSA ca30(s[27], c[27], s[28], s[29], c[29]);
    CSA ca31(c[28], s[29], c[29], s[30], c[30]);


// sixtyFourBitAdder SRA(s[30], c[30], 1'b0, C, K)
    RecursiveDoubling cla1(s[30][31:0],c[30][31:0],1'b0,C[31:0],cout);
    RecursiveDoubling cla2(s[30][63:32],c[30][63:32],cout,C[63:32],cout1);

    



endmodule