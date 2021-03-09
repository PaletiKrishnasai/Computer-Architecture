`include "adder32/adder32alt.v"

module getdif(input [8:1]exp_a,input [8:1]exp_b,output reg [8:1] dif );
    always@(exp_a or exp_b) begin
        dif=exp_a-exp_b;
    end
endmodule

module mux21(input [9:1] exp_c,input [32:1] a,input [32:1] b,output [9:1] exp_cs);

wire [9:1]exp_c2,sel;
wire s;
assign exp_c2=9'b1111_1111_1;
wire [9:1]t1,t2,t3;

assign s=((exp_c>255) ||(a[31:24]==255) ||(b[31:24]==255) );
assign sel={8{s}};

assign t1=exp_c2 & sel;

assign t2=exp_c & (~sel);

assign t3=t1|t2;

assign exp_cs=t3;

endmodule

module mux22(input ch,input [9:1]exp_c,output [9:1] exp_cs);

assign exp_cs=exp_c+ch;

endmodule

module mux23(input [65:1] man_c,input [32:1] a,input [32:1] b,output [65:1] man_cs);

wire [65:1]t1,t2,t3,t4,t5,t6,sel,sel2,man_c2,man_c3;
wire s,s2;
assign s=(a[23:1]!=0 || b[23:1]!=0);
assign sel={65{s}};
assign man_c2=65'h0000_0010_0000_0000;
assign man_c3={65{1'b0}};

assign t1=sel &man_c2;
assign t2=man_c3 & (~sel);
assign t3=t1|t2;

assign s2=( ((a[31:24]==255 && a[23:1]!=0) || (b[31:24]==255 && b[23:1]!=0)) || ((a[31:24]==255 && a[23:1]==0) || (b[31:24]==255 && b[23:1]==0)) );
assign sel2={65{s2}};

assign t4=sel2 & t3;
assign t5=man_c &(~sel2);
assign t6=t4 | t5;

assign man_cs=t6;

endmodule

module mux24(input ch,input [65:1] man_cs,input [9:1]exp_cs,input [32:1] a,input [32:1] b,output [32:1] c);

wire [65:1]t1,t2,t3,sel,man_c2,man_c3;
reg [65:1] t7;
wire s;
assign s=(a[31:1]==0 || b[31:1]==0);
assign sel={65{s}};
assign man_c2=man_cs;
assign man_c3={65{1'b0}};

assign t1=man_c3 & sel;
assign t2=man_c2 & (~sel);
assign t3=t1|t2;

wire [9:1] t4,t5,t6,sel2,exp_c2,exp_c3;
assign sel2={9{s}};
assign exp_c2={9{1'b0}};
assign exp_c3=exp_cs;

assign t4= exp_c2 & sel2;
assign t5= exp_c3 & (~sel2);
assign t6=t4|t5;

always@(*)
if(ch==1'b1)
t7[47:25]=t3[47:25];
else
t7[47:25]=t3[46:24];



assign c[23:1]=t7[47:25];
assign c[31:24] =t6[8:1];


endmodule


module comparator(input [32:1] man_a,input [32:1] man_bs,input sa,input sb,output [32:1] sum);
    reg [32:1] man_b;
    
    always@(*)
    begin
        man_b=32'b0;
        if(sa==sb)
        man_b={man_bs[32:1]}; //duplicate as it is
        else
        begin
        man_b=~man_bs+1'b1; //1's complement + 1 =2's complement
        end

    end
    adder m_0(sum,man_a,man_b);
    assign sum[32]=1'b0;

endmodule


