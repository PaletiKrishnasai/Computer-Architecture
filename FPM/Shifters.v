module Shift(input [31:0]A, input [7:0]shift, output [31:0]B);
    assign B = A>>shift;
endmodule 


module mux(A,B,S,out);

  input A;
  input B;
  input S;
  output out;
  assign out=(S==0)?B:A; //no shift case

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

module LeftShift (input [31:0]A, input [7:0]shift, output [31:0]B);
    genvar i;
    generate
    for (i = 0; i < 8'b11111111 ; i = i + 1) 
    begin

        wire [31:0]tmp;

        if(i == 8'b0)
        begin
            assign tmp = A;
        end

        else if(i <= 5'b11111)
        begin
            assign tmp[31:i] = A[31-i:0];
            assign tmp[i-1'b1:0] = 1'b0;
        end

        else 
            assign tmp = 32'b0;

        assign enable = ~|(shift ^ i);

        assign B[31:0] = enable ? tmp[31:0] : 32'bz;

    end
    endgenerate
endmodule

module barrel_logicalLeft(Inp,S,out);      

	input[22:0] Inp;      //23-bit Input line 
	input[4:0] S;       //5 bit Shift magnitude
	output[22:0] out;   //8-bit Output line 

	wire s1_1, s1_2, s1_3, s1_4, s1_5, s1_6, s1_7, s1_8, s1_9, s1_10, s1_11, s1_12, s1_13, s1_14, s1_15, s1_16, s1_17, s1_18, s1_19, s1_20, s1_21, s1_22, s1_23;
	wire s2_1, s2_2, s2_3, s2_4, s2_5, s2_6, s2_7, s2_8, s2_9, s2_10, s2_11, s2_12, s2_13, s2_14, s2_15, s2_16, s2_17, s2_18, s2_19, s2_20, s2_21, s2_22, s2_23;
	wire s3_1, s3_2, s3_3, s3_4, s3_5, s3_6, s3_7, s3_8, s3_9, s3_10, s3_11, s3_12, s3_13, s3_14, s3_15, s3_16, s3_17, s3_18, s3_19, s3_20, s3_21, s3_22, s3_23;
	wire s4_1, s4_2, s4_3, s4_4, s4_5, s4_6, s4_7, s4_8, s4_9, s4_10, s4_11, s4_12, s4_13, s4_14, s4_15, s4_16, s4_17, s4_18, s4_19, s4_20, s4_21, s4_22, s4_23;

	//COLUMN 1
	mux m1(1'b0, Inp[0], S[0], s1_1);
	mux m2(Inp[0], Inp[1], S[0], s1_2);
	mux m3(Inp[1], Inp[2], S[0], s1_3);
	mux m4(Inp[2], Inp[3], S[0], s1_4);
	mux m5(Inp[3], Inp[4], S[0], s1_5);
	mux m6(Inp[4], Inp[5], S[0], s1_6);
	mux m7(Inp[5], Inp[6], S[0], s1_7);
	mux m8(Inp[6], Inp[7], S[0], s1_8);
	mux m9(Inp[7], Inp[8], S[0], s1_9);
	mux m10(Inp[8], Inp[9], S[0], s1_10);
	mux m11(Inp[9], Inp[10], S[0], s1_11);
	mux m12(Inp[10], Inp[11], S[0], s1_12);
	mux m13(Inp[11], Inp[12], S[0], s1_13);
	mux m14(Inp[12], Inp[13], S[0], s1_14);
	mux m15(Inp[13], Inp[14], S[0], s1_15);
	mux m16(Inp[14], Inp[15], S[0], s1_16);
	mux m17(Inp[15], Inp[16], S[0], s1_17);
	mux m18(Inp[16], Inp[17], S[0], s1_18);
	mux m19(Inp[17], Inp[18], S[0], s1_19);
	mux m20(Inp[18], Inp[19], S[0], s1_20);
	mux m21(Inp[19], Inp[20], S[0], s1_21);
	mux m22(Inp[20], Inp[21], S[0], s1_22);
	mux m23(Inp[21], Inp[22], S[0], s1_23);

	//COLUMN 2
	mux m25(1'b0, s1_1, S[1], s2_1);
	mux m26(1'b0, s1_2, S[1], s2_2);
	mux m27(s1_1, s1_3, S[1], s2_3);
	mux m28(s1_2, s1_4, S[1], s2_4);
	mux m29(s1_3, s1_5, S[1], s2_5);
	mux m30(s1_4, s1_6, S[1], s2_6);
	mux m31(s1_5, s1_7, S[1], s2_7);
	mux m32(s1_6, s1_8, S[1], s2_8);
	mux m33(s1_7, s1_9, S[1], s2_9);
	mux m34(s1_8, s1_10, S[1], s2_10);
	mux m35(s1_9, s1_11, S[1], s2_11);
	mux m36(s1_10, s1_12, S[1], s2_12);
	mux m37(s1_11, s1_13, S[1], s2_13);
	mux m38(s1_12, s1_14, S[1], s2_14);
	mux m39(s1_13, s1_15, S[1], s2_15);
	mux m40(s1_14, s1_16, S[1], s2_16);
	mux m41(s1_15, s1_17, S[1], s2_17);
	mux m42(s1_16, s1_18, S[1], s2_18);
	mux m43(s1_17, s1_19, S[1], s2_19);
	mux m44(s1_18, s1_20, S[1], s2_20);
	mux m45(s1_19, s1_21, S[1], s2_21);
	mux m46(s1_20, s1_22, S[1], s2_22);
	mux m47(s1_21, s1_23, S[1], s2_23);

	//COLUMN 3
	mux m49(1'b0, s2_1, S[2], s3_1);
	mux m50(1'b0, s2_2, S[2], s3_2);
	mux m51(1'b0, s2_3, S[2], s3_3);
	mux m52(1'b0, s2_4, S[2], s3_4);
	mux m53(s2_1, s2_5, S[2], s3_5);
	mux m54(s2_2, s2_6, S[2], s3_6);
	mux m55(s2_3, s2_7, S[2], s3_7);
	mux m56(s2_4, s2_8, S[2], s3_8);
	mux m57(s2_5, s2_9, S[2], s3_9);
	mux m58(s2_6, s2_10, S[2], s3_10);
	mux m59(s2_7, s2_11, S[2], s3_11);
	mux m60(s2_8, s2_12, S[2], s3_12);
	mux m61(s2_9, s2_13, S[2], s3_13);
	mux m62(s2_10, s2_14, S[2], s3_14);
	mux m63(s2_11, s2_15, S[2], s3_15);
	mux m64(s2_12, s2_16, S[2], s3_16);
	mux m65(s2_13, s2_17, S[2], s3_17);
	mux m66(s2_14, s2_18, S[2], s3_18);
	mux m67(s2_15, s2_19, S[2], s3_19);
	mux m68(s2_16, s2_20, S[2], s3_20);
	mux m69(s2_17, s2_21, S[2], s3_21);
	mux m70(s2_18, s2_22, S[2], s3_22);
	mux m71(s2_19, s2_23, S[2], s3_23);

	//COLUMN 4
	mux m73(1'b0, s3_1, S[3], s4_1);
	mux m74(1'b0, s3_2, S[3], s4_2);
	mux m75(1'b0, s3_3, S[3], s4_3);
	mux m76(1'b0, s3_4, S[3], s4_4);
	mux m77(1'b0, s3_5, S[3], s4_5);
	mux m78(1'b0, s3_6, S[3], s4_6);
	mux m79(1'b0, s3_7, S[3], s4_7);
	mux m80(1'b0, s3_8, S[3], s4_8);
	mux m81(s3_1, s3_9, S[3], s4_9);
	mux m82(s3_2, s3_10, S[3], s4_10);
	mux m83(s3_3, s3_11, S[3], s4_11);
	mux m84(s3_4, s3_12, S[3], s4_12);
	mux m85(s3_5, s3_13, S[3], s4_13);
	mux m86(s3_6, s3_14, S[3], s4_14);
	mux m87(s3_7, s3_15, S[3], s4_15);
	mux m88(s3_8, s3_16, S[3], s4_16);
	mux m89(s3_9, s3_17, S[3], s4_17);
	mux m90(s3_10, s3_18, S[3], s4_18);
	mux m91(s3_11, s3_19, S[3], s4_19);
	mux m92(s3_12, s3_20, S[3], s4_20);
	mux m93(s3_13, s3_21, S[3], s4_21);
	mux m94(s3_14, s3_22, S[3], s4_22);
	mux m95(s3_15, s3_23, S[3], s4_23);

	//COLUMN 5
	mux m97(1'b0, s4_1, S[4], out[0]);
	mux m98(1'b0, s4_2, S[4], out[1]);
	mux m99(1'b0, s4_3, S[4], out[2]);
	mux m100(1'b0, s4_4, S[4], out[3]);
	mux m101(1'b0, s4_5, S[4], out[4]);
	mux m102(1'b0, s4_6, S[4], out[5]);
	mux m103(1'b0, s4_7, S[4], out[6]);
	mux m104(1'b0, s4_8, S[4], out[7]);
	mux m105(1'b0, s4_9, S[4], out[8]);
	mux m106(1'b0, s4_10, S[4], out[9]);
	mux m107(1'b0, s4_11, S[4], out[10]);
	mux m108(1'b0, s4_12, S[4], out[11]);
	mux m109(1'b0, s4_13, S[4], out[12]);
	mux m110(1'b0, s4_14, S[4], out[13]);
	mux m111(1'b0, s4_15, S[4], out[14]);
	mux m112(1'b0, s4_16, S[4], out[15]);
	mux m113(s4_1, s4_17, S[4], out[16]);
	mux m114(s4_2, s4_18, S[4], out[17]);
	mux m115(s4_3, s4_19, S[4], out[18]);
	mux m116(s4_4, s4_20, S[4], out[19]);
	mux m117(s4_5, s4_21, S[4], out[20]);
	mux m118(s4_6, s4_22, S[4], out[21]);
	mux m119(s4_7, s4_23, S[4], out[22]);
	
/*	always@(*)
	begin
		$display("\n	%B 	\n",out);
	end
*/

endmodule

module barrel_logicalRight(Inp,S,out);   

	input[23:0] Inp;      //24-bit Input line 
	input[4:0] S;       //5 bit Shift magnitude
	output[23:0] out;   //8-bit Output line 

	wire s1_1, s1_2, s1_3, s1_4, s1_5, s1_6, s1_7, s1_8, s1_9, s1_10, s1_11, s1_12, s1_13, s1_14, s1_15, s1_16, s1_17, s1_18, s1_19, s1_20, s1_21, s1_22, s1_23, s1_24;
	wire s2_1, s2_2, s2_3, s2_4, s2_5, s2_6, s2_7, s2_8, s2_9, s2_10, s2_11, s2_12, s2_13, s2_14, s2_15, s2_16, s2_17, s2_18, s2_19, s2_20, s2_21, s2_22, s2_23, s2_24;
	wire s3_1, s3_2, s3_3, s3_4, s3_5, s3_6, s3_7, s3_8, s3_9, s3_10, s3_11, s3_12, s3_13, s3_14, s3_15, s3_16, s3_17, s3_18, s3_19, s3_20, s3_21, s3_22, s3_23, s3_24;
	wire s4_1, s4_2, s4_3, s4_4, s4_5, s4_6, s4_7, s4_8, s4_9, s4_10, s4_11, s4_12, s4_13, s4_14, s4_15, s4_16, s4_17, s4_18, s4_19, s4_20, s4_21, s4_22, s4_23, s4_24;

	//COLUMN 1
	mux m1(Inp[1], Inp[0], S[0], s1_1);
	mux m2(Inp[2], Inp[1], S[0], s1_2);
	mux m3(Inp[3], Inp[2], S[0], s1_3);
	mux m4(Inp[4], Inp[3], S[0], s1_4);
	mux m5(Inp[5], Inp[4], S[0], s1_5);
	mux m6(Inp[6], Inp[5], S[0], s1_6);
	mux m7(Inp[7], Inp[6], S[0], s1_7);
	mux m8(Inp[8], Inp[7], S[0], s1_8);
	mux m9(Inp[9], Inp[8], S[0], s1_9);
	mux m10(Inp[10], Inp[9], S[0], s1_10);
	mux m11(Inp[11], Inp[10], S[0], s1_11);
	mux m12(Inp[12], Inp[11], S[0], s1_12);
	mux m13(Inp[13], Inp[12], S[0], s1_13);
	mux m14(Inp[14], Inp[13], S[0], s1_14);
	mux m15(Inp[15], Inp[14], S[0], s1_15);
	mux m16(Inp[16], Inp[15], S[0], s1_16);
	mux m17(Inp[17], Inp[16], S[0], s1_17);
	mux m18(Inp[18], Inp[17], S[0], s1_18);
	mux m19(Inp[19], Inp[18], S[0], s1_19);
	mux m20(Inp[20], Inp[19], S[0], s1_20);
	mux m21(Inp[21], Inp[20], S[0], s1_21);
	mux m22(Inp[22], Inp[21], S[0], s1_22);
	mux m23(Inp[23], Inp[22], S[0], s1_23);
	mux m24(1'b0, Inp[23], S[0], s1_24);

	//COLUMN 2
	mux m25(s1_3, s1_1, S[1], s2_1);
	mux m26(s1_4, s1_2, S[1], s2_2);
	mux m27(s1_5, s1_3, S[1], s2_3);
	mux m28(s1_6, s1_4, S[1], s2_4);
	mux m29(s1_7, s1_5, S[1], s2_5);
	mux m30(s1_8, s1_6, S[1], s2_6);
	mux m31(s1_9, s1_7, S[1], s2_7);
	mux m32(s1_10, s1_8, S[1], s2_8);
	mux m33(s1_11, s1_9, S[1], s2_9);
	mux m34(s1_12, s1_10, S[1], s2_10);
	mux m35(s1_13, s1_11, S[1], s2_11);
	mux m36(s1_14, s1_12, S[1], s2_12);
	mux m37(s1_15, s1_13, S[1], s2_13);
	mux m38(s1_16, s1_14, S[1], s2_14);
	mux m39(s1_17, s1_15, S[1], s2_15);
	mux m40(s1_18, s1_16, S[1], s2_16);
	mux m41(s1_19, s1_17, S[1], s2_17);
	mux m42(s1_20, s1_18, S[1], s2_18);
	mux m43(s1_21, s1_19, S[1], s2_19);
	mux m44(s1_22, s1_20, S[1], s2_20);
	mux m45(s1_23, s1_21, S[1], s2_21);
	mux m46(s1_24, s1_22, S[1], s2_22);
	mux m47(1'b0, s1_23, S[1], s2_23);
	mux m48(1'b0, s1_24, S[1], s2_24);

	//COLUMN 3
	mux m49(s2_5, s2_1, S[2], s3_1);
	mux m50(s2_6, s2_2, S[2], s3_2);
	mux m51(s2_7, s2_3, S[2], s3_3);
	mux m52(s2_8, s2_4, S[2], s3_4);
	mux m53(s2_9, s2_5, S[2], s3_5);
	mux m54(s2_10, s2_6, S[2], s3_6);
	mux m55(s2_11, s2_7, S[2], s3_7);
	mux m56(s2_12, s2_8, S[2], s3_8);
	mux m57(s2_13, s2_9, S[2], s3_9);
	mux m58(s2_14, s2_10, S[2], s3_10);
	mux m59(s2_15, s2_11, S[2], s3_11);
	mux m60(s2_16, s2_12, S[2], s3_12);
	mux m61(s2_17, s2_13, S[2], s3_13);
	mux m62(s2_18, s2_14, S[2], s3_14);
	mux m63(s2_19, s2_15, S[2], s3_15);
	mux m64(s2_20, s2_16, S[2], s3_16);
	mux m65(s2_21, s2_17, S[2], s3_17);
	mux m66(s2_22, s2_18, S[2], s3_18);
	mux m67(s2_23, s2_19, S[2], s3_19);
	mux m68(s2_24, s2_20, S[2], s3_20);
	mux m69(1'b0, s2_21, S[2], s3_21);
	mux m70(1'b0, s2_22, S[2], s3_22);
	mux m71(1'b0, s2_23, S[2], s3_23);
	mux m72(1'b0, s2_24, S[2], s3_24);

	//COLUMN 4
	mux m73(s3_9, s3_1, S[3], s4_1);
	mux m74(s3_10, s3_2, S[3], s4_2);
	mux m75(s3_11, s3_3, S[3], s4_3);
	mux m76(s3_12, s3_4, S[3], s4_4);
	mux m77(s3_13, s3_5, S[3], s4_5);
	mux m78(s3_14, s3_6, S[3], s4_6);
	mux m79(s3_15, s3_7, S[3], s4_7);
	mux m80(s3_16, s3_8, S[3], s4_8);
	mux m81(s3_17, s3_9, S[3], s4_9);
	mux m82(s3_18, s3_10, S[3], s4_10);
	mux m83(s3_19, s3_11, S[3], s4_11);
	mux m84(s3_20, s3_12, S[3], s4_12);
	mux m85(s3_21, s3_13, S[3], s4_13);
	mux m86(s3_22, s3_14, S[3], s4_14);
	mux m87(s3_23, s3_15, S[3], s4_15);
	mux m88(s3_24, s3_16, S[3], s4_16);
	mux m89(1'b0, s3_17, S[3], s4_17);
	mux m90(1'b0, s3_18, S[3], s4_18);
	mux m91(1'b0, s3_19, S[3], s4_19);
	mux m92(1'b0, s3_20, S[3], s4_20);
	mux m93(1'b0, s3_21, S[3], s4_21);
	mux m94(1'b0, s3_22, S[3], s4_22);
	mux m95(1'b0, s3_23, S[3], s4_23);
	mux m96(1'b0, s3_24, S[3], s4_24);

	//COLUMN 5
	mux m97(s4_17, s4_1, S[4], out[0]);
	mux m98(s4_18, s4_2, S[4], out[1]);
	mux m99(s4_19, s4_3, S[4], out[2]);
	mux m100(s4_20, s4_4, S[4], out[3]);
	mux m101(s4_21, s4_5, S[4], out[4]);
	mux m102(s4_22, s4_6, S[4], out[5]);
	mux m103(s4_23, s4_7, S[4], out[6]);
	mux m104(s4_24, s4_8, S[4], out[7]);
	mux m105(1'b0, s4_9, S[4], out[8]);
	mux m106(1'b0, s4_10, S[4], out[9]);
	mux m107(1'b0, s4_11, S[4], out[10]);
	mux m108(1'b0, s4_12, S[4], out[11]);
	mux m109(1'b0, s4_13, S[4], out[12]);
	mux m110(1'b0, s4_14, S[4], out[13]);
	mux m111(1'b0, s4_15, S[4], out[14]);
	mux m112(1'b0, s4_16, S[4], out[15]);
	mux m113(1'b0, s4_17, S[4], out[16]);
	mux m114(1'b0, s4_18, S[4], out[17]);
	mux m115(1'b0, s4_19, S[4], out[18]);
	mux m116(1'b0, s4_20, S[4], out[19]);
	mux m117(1'b0, s4_21, S[4], out[20]);
	mux m118(1'b0, s4_22, S[4], out[21]);
	mux m119(1'b0, s4_23, S[4], out[22]);
	mux m120(1'b0, s4_24, S[4], out[23]);

endmodule