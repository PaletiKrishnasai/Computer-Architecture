module fullAdder (a,b,cin,sum,ca);//module name similar to c
input a,b,cin;
output sum,ca;

assign sum = a ^ b ^ cin;//a xor b xor c
assign ca= (a&b) | (a&cin) |(cin&b) ;// a and b or a and c or b and c

endmodule
