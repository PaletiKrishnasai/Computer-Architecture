`include "adder32/adder32alt.v"

module getdif(input [8:1]exp_a,input [8:1]exp_b,output reg [8:1] dif );
    always@(exp_a or exp_b) begin
        dif=exp_a-exp_b;
    end
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


