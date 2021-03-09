module getval(
    input [32:1] a,
    input [32:1] b,
    output reg [32:1] man_a,
    output reg [32:1] man_b,
    output reg [8:1] exp_a,
    output reg [8:1] exp_b,
    output reg sign_a,
    output reg sign_b
    
);

always@(*)begin
    man_a={32'b0};
    man_b={32'b0};
    man_a [23:1] = a[23:1];
    man_b [23:1] = b[23:1];
    exp_a =a[31:24];
    exp_b =b[31:24];
    sign_a =a[32];
    sign_b =b[32];

    man_a[24]=1'b1; //1.man_a
    man_b[24]=1'b1; //1.man_b
    end



endmodule