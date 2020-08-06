module FullAdder(a,b,cin,sum,cout);

input a,b,cin;
output cout,sum;

assign {cout,sum} = a+b+cin;

endmodule
//-------------------------------------------------------
module multiplexer(a0,a1,sel,out);

input[3:0] a0,a1;
input sel;
output[3:0] out;

assign out = (sel==0)?a0:
	     (sel==1)?a1:a0;

endmodule
//-------------------------------------------------------
module Four_Bit_Ripple_Carry_Adder(a,b,cin,sum,cout);

input [3:0] a,b;
input cin;
output [3:0] sum;
output cout;

wire[2:0] w;

FullAdder F0(a[0],b[0],cin,sum[0],w[0]);
FullAdder F1(a[1],b[1],w[0],sum[1],w[1]);
FullAdder F2(a[2],b[2],w[1],sum[2],w[2]);
FullAdder F3(a[3],b[3],w[2],sum[3],cout);

endmodule
//-------------------------------------------------------
module Four_Bit_Carry_Select_Adder(a,b,cin,sum,cout);

input [3:0] a,b;
input cin;
output [3:0] sum;
output cout;

wire[3:0] sum0,sum1;
wire c0,c1;

Four_Bit_Ripple_Carry_Adder F1(a[3:0],b[3:0],1'b0,sum0[3:0],c0);
Four_Bit_Ripple_Carry_Adder F2(a[3:0],b[3:0],1'b1,sum1[3:0],c1);

multiplexer m1(sum0 [3:0],sum1[3:0],cin,sum[3:0]);
multiplexer m2(c0,c1,cin,cout);

endmodule
//-------------------------------------------------------
module CarrySelectAdder(a,b,cin,sum,cout);

input [15:0] a,b;
input cin;
output cout;
output [15:0] sum;

wire W0,W1,W2;
wire [2:0] w;

Four_Bit_Ripple_Carry_Adder Frb(a[3:0],b[3:0],cin,sum[3:0],W0);

Four_Bit_Carry_Select_Adder Fcs1(a[7:4],b[7:4],W0,sum[7:4],W1);
Four_Bit_Carry_Select_Adder Fcs2(a[11:8],b[11:8],W1,sum[11:8],W2);
Four_Bit_Carry_Select_Adder Fcs3(a[15:12],b[15:12],W2,sum[15:12],cout);

endmodule 