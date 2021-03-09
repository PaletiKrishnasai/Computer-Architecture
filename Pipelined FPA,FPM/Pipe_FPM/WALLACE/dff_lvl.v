module dff_lvl_1 (input [31:0][64:0]d,input [32:1]a2,input [32:1]b2,input [9:1]exp_c,input sign_c,input rst,input clk,output reg [31:0][64:0] q,output reg [74:1] comb);  
  
    always@(posedge clk )  
       if (!rst)  
       begin
          q <= 0;
          comb <= 0;
       end
       else  
       begin
          q <= d;
          comb[32:1] <= a2;
          comb[64:33] <= b2;
          comb[73:65] <= exp_c;
          comb[74] <= sign_c;  

       end
endmodule  

module dff_lvl_2 (input [9:0][64:0]d1,input [9:0][64:0]d2,input [74:1] comb,input rst,input clk,output reg [9:0][64:0] q1,output reg [9:0][64:0] q2,output reg [74:1] comb1);  
  
    always@(posedge clk )  
       if (!rst)  
       begin
          q1 <= 0; 
          q2 <= 0;
          comb1<=0; 
       end
       else  
       begin
          q1 <= d1;  
          q2 <= d2;
          comb1<=comb;
       end
endmodule  

module dff_lvl_3 (input [6:0][64:0]d1,input [6:0][64:0]d2,input [74:1] comb,input rst,input clk,output reg [6:0][64:0] q1,output reg [6:0][64:0] q2,output reg [74:1] comb1);  
  
    always@(posedge clk )  
       if (!rst)  
       begin
          q1 <= 0; 
          q2 <= 0; 
          comb1<=0; 
       end
       else  
       begin
          q1 <= d1;  
          q2 <= d2;
          comb1<=comb;
       end
endmodule  

module dff_lvl_4 (input [4:0][64:0]d1,input [4:0][64:0]d2,input [74:1] comb,input rst,input clk,output reg [4:0][64:0] q1,output reg [4:0][64:0] q2,output reg [74:1] comb1);  
  
    always@(posedge clk )  
       if (!rst)  
       begin
          q1 <= 0; 
          q2 <= 0; 
          comb1<=0; 
       end
       else  
       begin
          q1 <= d1;  
          q2 <= d2;
          comb1<=comb;
       end
endmodule  

module dff_lvl_5 (input [2:0][64:0]d1,input [2:0][64:0]d2,input [74:1] comb,input rst,input clk,output reg [2:0][64:0] q1,output reg [2:0][64:0] q2,output reg [74:1] comb1);  
  
    always@(posedge clk )  
       if (!rst)  
       begin
          q1 <= 0; 
          q2 <= 0; 
          comb1<=0; 
       end
       else  
       begin
          q1 <= d1;  
          q2 <= d2;
          comb1<=comb;
       end
endmodule  

module dff_lvl_6 (input [1:0][64:0]d1,input [1:0][64:0]d2,input [74:1] comb,input rst,input clk,output reg [1:0][64:0] q1,output reg [1:0][64:0] q2,output reg [74:1] comb1);  
  
    always@(posedge clk )  
       if (!rst)  
       begin
          q1 <= 0; 
          q2 <= 0; 
          comb1<=0; 
       end
       else  
       begin
          q1 <= d1;  
          q2 <= d2;
          comb1<=comb;
       end
endmodule  

module dff_lvl_7 (input [64:0]d1,input [64:0]d2,input [74:1] comb,input rst,input clk,output reg [64:0] q1,output reg [64:0] q2,output reg [74:1] comb1);  
  
    always@(posedge clk )  
       if (!rst)  
       begin
          q1 <= 0; 
          q2 <= 0;
          comb1<=0;  
       end
       else  
       begin
          q1 <= d1;  
          q2 <= d2;
          comb1<=comb;
       end
endmodule  