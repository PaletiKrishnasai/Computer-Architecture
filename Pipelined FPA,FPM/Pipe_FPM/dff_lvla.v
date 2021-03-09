module dff_lvl_p2 (input [31:0]a1,input [31:0]a2,input [32:0]d1,input [32:0]d2,input [7:0]d3,input [7:0]d4,input d5,input d6,input rst,input clk,output reg [31:0] b1,output reg [31:0] b2,output reg [32:0] q1,output reg [32:0] q2,output reg [7:0] q3,output reg [7:0] q4,output reg q5,output reg q6);  
  
     always@(posedge clk )  
       if (!rst)  
       begin
          q1 <= 0;
          q2 <= 0;
          q3 <= 0;
          q4 <= 0;
          q5 <= 0;
          q6 <= 0;
          b1 <= 0;
          b2 <= 0; 
       end
       else  
       begin
          q1 <= d1;
          q2 <= d2;
          q3 <= d3;
          q4 <= d4;
          q5 <= d5;
          q6 <= d6;
          b1 <= a1;
          b2 <= a2;  

       end
endmodule  



module dff_lvl_p1 (input [32:1]a,input [32:1]b,input rst,input clk,output reg [31:0] c,output reg [31:0] d);  
  
    always@(posedge clk )  
       if (!rst)  
       begin
          c <= 0; 
          d <= 0; 
       end
       else  
       begin
          c <= a;  
          d <= b;
       end
endmodule 

module dff_lvl_p3 (input a,input [8:1]b,input [32:1]c,input rst,input clk,output reg [31:0] q);  
  
    always@(posedge clk )  
       if (!rst)  
       begin
          q <= 0; 
       end
       else  
       begin
          q[31]<=a;
          q[30:23]<=b;
          q[22:0]<=c[23:1];
       end
endmodule  