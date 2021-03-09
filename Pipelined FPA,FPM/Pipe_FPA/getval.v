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

always@(a or b)begin
    if(a[31:1]>b[31:1])begin
    man_a={32'b0};
    man_b={32'b0};
    man_a [23:1] = a[23:1];
    man_b [23:1] = b[23:1];
    exp_a =a[31:24];
    exp_b =b[31:24];
    sign_a =a[32];
    sign_b =b[32];
end
else begin
    man_a=32'b0;
    man_b=32'b0;
    man_a [23:1] = b[23:1];
    man_b [23:1] = a[23:1];
    exp_b =a[31:24];
    exp_a =b[31:24];
    sign_b =a[32];
    sign_a =b[32];
end
    man_a[24]=1'b1; //1.man_a
    man_b[24]=1'b1; //1.man_b
    if(a[31:24]==8'd0 && a[23:1]!=8'd0) //subnormal of a
    exp_a=-1;
    if(b[31:24]==8'd0 && b[23:1]!=8'd0) //subnormal of a
    exp_b=-1;

end


endmodule