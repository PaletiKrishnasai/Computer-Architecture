module bs_right (
    input [31:0]in,
    input [7:0]dif,
    input sh_bit,rot_bit,
    output reg [31:0] sh_in
    );
reg [4:0] sh;
reg [7:0] q;
integer i;
always@(*)
begin

if(sh_bit==1'b1)
    sh=dif[4:0];

else
begin //every time a barrel shift is done after 31 shift ,its the same number so reduce dif range to 31
    q=dif;
    while(q>32)
        q=q-32;
    sh=q[4:0];
end

if(~sh_bit) //if not right shift  do left shift
sh_in = in<<sh;
else if(sh_bit) //do right shift
begin
if(sh==5'b00001)
sh_in={1'b0,in[31:1]};
else if(sh==5'b00010)
sh_in={2'b0,in[31:2]};
else if(sh==5'b00011)
sh_in={3'b0,in[31:3]};
else if(sh==5'b00100)
sh_in={4'b0,in[31:4]};
else if(sh==5'b00101)
sh_in={5'b0,in[31:5]};
else if(sh==5'b00110)
sh_in={6'b0,in[31:6]};
else if(sh==5'b00111)
sh_in={7'b0,in[31:7]};
else if(sh==5'b01000)
sh_in={8'b0,in[31:8]};
else if(sh==5'b01001)
sh_in={9'b0,in[31:9]};
else if(sh==5'b01010)
sh_in={10'b0,in[31:10]};
else if(sh==5'b01011)
sh_in={11'b0,in[31:11]};
else if(sh==5'b01100)
sh_in={12'b0,in[31:12]};
else if(sh==5'b01101)
sh_in={13'b0,in[31:13]};
else if(sh==5'b01110)
sh_in={14'b0,in[31:14]};
else if(sh==5'b01111)
sh_in={15'b0,in[31:15]};
else if(sh==5'b10000)
sh_in={16'b0,in[31:16]};
else if(sh==5'b10001)
sh_in={17'b0,in[31:17]};
else if(sh==5'b10010)
sh_in={18'b0,in[31:18]};
else if(sh==5'b10011)
sh_in={19'b0,in[31:19]};
else if(sh==5'b10100)
sh_in={20'b0,in[31:20]};
else if(sh==5'b10101)
sh_in={21'b0,in[31:21]};
else if(sh==5'b10110)
sh_in={22'b0,in[31:22]};
else if(sh==5'b10111)
sh_in={23'b0,in[31:23]};
else if(sh==5'b11000)
sh_in={24'b0,in[31:24]};
else if(sh==5'b11001)
sh_in={25'b0,in[31:25]};
else if(sh==5'b11010)
sh_in={26'b0,in[31:26]};
else if(sh==5'b11011)
sh_in={27'b0,in[31:27]};
else if(sh==5'b11100)
sh_in={28'b0,in[31:28]};
else if(sh==5'b11101)
sh_in={29'b0,in[31:29]};
else if(sh==5'b11101)
sh_in={30'b0,in[31:30]};
else if(sh==5'b11111)
sh_in={31'b0,in[31:31]};
else 
begin
    if(dif>'d31)
    begin
    sh=5'd0;
    sh_in=32'd0;
    end
    else
    sh_in=in;
end
end
else // do barrel shift ,if not right barrel shift ->do left barrel shift else right barrel shift
begin
if(sh==5'b00001)
sh_in=(~rot_bit)?{in[31-1:0],in[31]}:{in[0],in[31:1]};
else if(sh==5'b00010)
sh_in=(~rot_bit)?{in[31-2:0],in[31:31-1]}:{in[1:0],in[31:2]};
else if(sh==5'b00011)
sh_in=(~rot_bit)?{in[31-3:0],in[31:31-2]}:{in[2:0],in[31:3]};
else if(sh==5'b00100)
sh_in=(~rot_bit)?{in[31-4:0],in[31:31-3]}:{in[3:0],in[31:4]};
else if(sh==5'b00101)
sh_in=(~rot_bit)?{in[31-5:0],in[31:31-4]}:{in[4:0],in[31:5]};
else if(sh==5'b00110)
sh_in=(~rot_bit)?{in[31-6:0],in[31:31-5]}:{in[5:0],in[31:6]};
else if(sh==5'b00111)
sh_in=(~rot_bit)?{in[31-7:0],in[31:31-6]}:{in[6:0],in[31:7]};
else if(sh==5'b01000)
sh_in=(~rot_bit)?{in[31-8:0],in[31:31-7]}:{in[7:0],in[31:8]};
else if(sh==5'b01001)
sh_in=(~rot_bit)?{in[31-9:0],in[31:31-8]}:{in[8:0],in[31:9]};
else if(sh==5'b01010)
sh_in=(~rot_bit)?{in[31-10:0],in[31:31-9]}:{in[9:0],in[31:10]};
else if(sh==5'b01011)
sh_in=(~rot_bit)?{in[31-11:0],in[31:31-10]}:{in[10:0],in[31:11]};
else if(sh==5'b01100)
sh_in=(~rot_bit)?{in[31-12:0],in[31:31-11]}:{in[11:0],in[31:12]};
else if(sh==5'b01101)
sh_in=(~rot_bit)?{in[31-13:0],in[31:31-12]}:{in[12:0],in[31:13]};
else if(sh==5'b01110)
sh_in=(~rot_bit)?{in[31-14:0],in[31:31-13]}:{in[13:0],in[31:14]};
else if(sh==5'b01111)
sh_in=(~rot_bit)?{in[31-15:0],in[31:31-14]}:{in[14:0],in[31:15]};
else if(sh==5'b10000)
sh_in=(~rot_bit)?{in[31-16:0],in[31:31-15]}:{in[15:0],in[31:16]};
else if(sh==5'b10001)
sh_in=(~rot_bit)?{in[31-17:0],in[31:31-16]}:{in[16:0],in[31:17]};
else if(sh==5'b10010)
sh_in=(~rot_bit)?{in[31-18:0],in[31:31-17]}:{in[17:0],in[31:18]};
else if(sh==5'b10011)
sh_in=(~rot_bit)?{in[31-19:0],in[31:31-18]}:{in[18:0],in[31:19]};
else if(sh==5'b10100)
sh_in=(~rot_bit)?{in[31-20:0],in[31:31-19]}:{in[19:0],in[31:20]};
else if(sh==5'b10101)
sh_in=(~rot_bit)?{in[31-21:0],in[31:31-20]}:{in[20:0],in[31:21]};
else if(sh==5'b10110)
sh_in=(~rot_bit)?{in[31-22:0],in[31:31-21]}:{in[21:0],in[31:22]};
else if(sh==5'b10111)
sh_in=(~rot_bit)?{in[31-23:0],in[31:31-22]}:{in[22:0],in[31:23]};
else if(sh==5'b11000)
sh_in=(~rot_bit)?{in[31-24:0],in[31:31-23]}:{in[23:0],in[31:24]};
else if(sh==5'b11001)
sh_in=(~rot_bit)?{in[31-25:0],in[31:31-24]}:{in[24:0],in[31:25]};
else if(sh==5'b11010)
sh_in=(~rot_bit)?{in[31-26:0],in[31:31-25]}:{in[25:0],in[31:26]};
else if(sh==5'b11011)
sh_in=(~rot_bit)?{in[31-27:0],in[31:31-26]}:{in[26:0],in[31:27]};
else if(sh==5'b11100)
sh_in=(~rot_bit)?{in[31-28:0],in[31:31-27]}:{in[27:0],in[31:28]};
else if(sh==5'b11101)
sh_in=(~rot_bit)?{in[31-29:0],in[31:31-28]}:{in[28:0],in[31:29]};
else if(sh==5'b11101)
sh_in=(~rot_bit)?{in[31-30:0],in[31:31-29]}:{in[29:0],in[31:30]};
else if(sh==5'b11111)
sh_in=(~rot_bit)?{in[31-31:0],in[31:31-30]}:{in[30:0],in[31:31]};
else 
    sh_in=in;

end
end
endmodule


