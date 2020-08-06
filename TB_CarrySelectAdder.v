module Adder_tb;

reg[15:0] A,B;
reg cin;

wire[15:0] sum;
wire cout;

integer i,j,k;

CarrySelectAdder Adder (A,B,cin,sum,cout);
//------------
initial begin
cin=0;
A[15:0]=0;
B[15:0]=0;
$display ("time\t  A                B                Cin Sum                Cout");	
$monitor ("%g\t  %b %b %b   %b   %b", 
  	   $time,A,B,cin, sum,cout);	
for(k=0;k<2;k=k+1)
begin
	cin=k;
	for(i=0;i<16;i=i+1)
	begin
		for(j=0;j<16;j=j+1)
		begin
			A=i;
			B=j;
			#10;
		end
	end
end

end

endmodule

//-----------------------------------------

module test_divided;
reg[15:0] A,B;
reg cin;

wire[15:0] sum;
wire cout;
//---------
wire W0,W1,W2;
wire [2:0] w;
integer i,j,k;

Four_Bit_Ripple_Carry_Adder Frb(A[3:0],B[3:0],cin,sum[3:0],W0);

Four_Bit_Carry_Select_Adder Fcs1(A[7:4],B[7:4],W0,sum[7:4],W1);
Four_Bit_Carry_Select_Adder Fcs2(A[11:8],B[11:8],W1,sum[11:8],W2);
Four_Bit_Carry_Select_Adder Fcs3(A[15:12],B[15:12],W2,sum[15:12],cout);

initial begin
cin=0;
A[15:0]=0;
B[15:0]=0;
$display ("time\t A                B                Cin Carry to RibbleAdder Carry to CarrySelectAdder1 Carry to CarrySelectAdder2 Carry to CarrySelectAdder3 Sum               Cout");	
$monitor ("%g\t %b %b %b   %b 	                  %b 			                      %b 		                       %b 		                       %b  %b", 
  	  $time, A, B, cin,cin,		   W0,                       W1,                        W2,                      sum,cout);	
for(k=0;k<2;k=k+1)
begin
	cin=k;
	for(i=32;i<64;i=i+1)
	begin
		for(j=16;j<32;j=j+1)
		begin
			A=i;
			B=j;
			#10;
		end
	end
end


end
endmodule
