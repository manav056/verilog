module pipeline_ex(F, A, B, C, D, clk);
	
	parameter N = 10;
	
	input [N - 1: 0] A, B, C, D;
	input clk;
	output [N - 1 : 0] F;
	reg [N - 1 : 0] L12_x1, L12_x2, L12_D, L23_x3, L23_D, L34_F;
	
	assign F = L34_F;
	
	always @(posedge clk)
		begin
			//Stage 1
			L12_x1 <= #4 A + B;
			L12_x2 <= #4 C - D;
			L12_D  <= D;
		end
		
		   //Stage 2
	always @(posedge clk)
	   begin
			L23_x3 <= #4 L12_x1 + L12_x2;
			L23_D  <= L12_D;
		end
			
			//Stage 3
	always @(posedge clk)
	   begin
			L34_F  <= #6 L23_x3 * L23_D; 
		end
		
endmodule