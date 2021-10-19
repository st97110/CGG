`timescale 10ns/100ps
module half_adder (output S, C, input x, y);
	xor #20 (S,x,y);
	and #10 (C,x,y);
endmodule

module full_adder (output S, C, input x, y, z);
	wire S1, C1 ,C2;
	half_adder HA1 (S1, C1 ,x, y);
	half_adder HA2 (S, C2, S1, z);
	or #15 G1 (C, C2, C1);
endmodule

module ripple_carry_4_bit_adder (output [3:0] Sum, output C4,input [3:0] A, B, input C0);
	wire C1, C2, C3;
	full_adder FA0 (Sum[0], C1, A[0], B[0], C0);
	full_adder FA1 (Sum[1], C2, A[1], B[1], C1);
	full_adder FA2 (Sum[2], C3, A[2], B[2], C2);
	full_adder FA3 (Sum[3], C4, A[3], B[3], C3);
endmodule

module ripple_carry_16_bit(sum, c4, a, b, c0);
input [15:0] a,b;
input c0;
output [15:0] sum;
output c4;
wire c1,c2,c3;
 
ripple_carry_4_bit_adder rca1 (sum[3:0], c1, a[3:0], b[3:0], c0);
 
ripple_carry_4_bit_adder rca2 (sum[7:4], c2, a[7:4], b[7:4], c1);
 
ripple_carry_4_bit_adder rca3 (sum[11:8], c3, a[11:8], b[11:8], c2);
 
ripple_carry_4_bit_adder rca4 (sum[15:12], c4, a[15:12], b[15:12], c3);
endmodule

module test_bench;
	wire [15:0] sum;
	wire Cout;
	reg [15:0] a, b;
	reg Cin;
	ripple_carry_16_bit test(sum, Cout, a, b, Cin);
	initial
	begin
			a = 16'd0; b = 16'd0; Cin = 1'd0;
			#500 a = 16'd61680; b = 16'd3855; Cin = 1'd1;
	end
	initial #1000 $finish;
	initial $dumpvars;
endmodule
