module multiplier (A, B, C);

    input [31:0] A;
    input B;
    output reg [31:0] C;
    
    always@(A, B)
    begin
        if(B != 0)
            C = A;
        else
            C = 32'b0000_0000_0000_0000_0000_0000_0000_0000;   
    end
    
endmodule