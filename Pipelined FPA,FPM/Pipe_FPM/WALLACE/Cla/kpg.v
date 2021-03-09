`include "WALLACE/Cla/2kpg.v"

module kpgga(x,ai,bi);

input [7:0] ai,bi;

output [7:0][7:0]x;

kpga kpg_0(x[0],ai[0],bi[0]);
kpga kpg_1(x[1],ai[1],bi[1]);
kpga kpg_2(x[2],ai[2],bi[2]);
kpga kpg_3(x[3],ai[3],bi[3]);
kpga kpg_4(x[4],ai[4],bi[4]);
kpga kpg_5(x[5],ai[5],bi[5]);
kpga kpg_6(x[6],ai[6],bi[6]);
kpga kpg_7(x[7],ai[7],bi[7]);



endmodule
