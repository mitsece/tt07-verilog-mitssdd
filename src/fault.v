module fault_pro(
	input [7:0] r0,
	input [1:0] check,
	input reset,
	input clk,
	output reg [2:0] out,
	output reg [1:0] out1);
	
	//data storing registers
	reg [9:0] r1=10'b0;  
	reg [9:0] r2=10'b0;
	reg [9:0] r3=10'b0;
	reg [9:0] r4=10'b0;

	//1st 4 set mean values
	reg [9:0] m1=10'b0;
	reg [9:0] m2=10'b0;
	reg [9:0] m3=10'b0;
	reg [9:0] m4=10'b0;

	//2nd 4 set mean values
	reg [9:0] w1=10'b0;
	reg [9:0] w2=10'b0;
	reg [9:0] w3=10'b0;
	reg [9:0] w4=10'b0;

	//Difference storing register
	reg [9:0] diff1=10'b0;  
	reg [9:0] diff2=10'b0;
	reg [9:0] diff3=10'b0;
	reg [9:0] diff4=10'b0;

	
	reg [2:0] counter1 = 3'b0;
	reg [2:0] counter2 = 3'b0;
	reg [2:0] counter3 = 3'b0;
	reg [2:0] counter4 = 3'b0;

	
	reg f1 = 1'b0;
	reg f2 = 1'b0;
	reg f3 = 1'b0;
	reg f4 = 1'b0;
	
	always @(posedge clk or posedge reset) begin
	
		if (reset) begin // Reset
			r1 <= 10'b0;
			r2 <= 10'b0;
			r3 <= 10'b0;
			r4 <= 10'b0;
			
			m1 <= 10'b0;
			m2 <= 10'b0;
			m3 <= 10'b0;
			m4 <= 10'b0;
			
			w1 <= 10'b0;
			w2 <= 10'b0;
			w3 <= 10'b0;
			w4 <= 10'b0;
			
			diff1 <= 10'b0;
			diff2 <= 10'b0;
			diff3 <= 10'b0;
			diff4 <= 10'b0;
			
			counter1 <= 3'b0;
			counter2 <= 3'b0;
			counter3 <= 3'b0;
			counter4 <= 3'b0;

			
			f1 <= 1'b0;
			f2 <= 1'b0;
			f3 <= 1'b0;
			f4 <= 1'b0;
			
			out <= 3'b0;
			out1 <= 2'b0;
			
		end else begin
		

				
				case (check)
					2'b00: begin
							r1 <= r1 + r0;
							counter1 <= counter1 + 1;
						end
					2'b01: begin
							r2 <= r2 + r0;
							counter2 <= counter2 + 1;
						end
					2'b10: begin
							r3 <= r3 + r0;
							counter3 <= counter3 + 1;
						end
					2'b11: begin
							r4 <= r4 + r0;
							counter4 <= counter4 + 1;
						end
				endcase
				
				if(f1 == 0 && counter1 == 4) begin //checking whether sum of 4 data was calculated 
					m1 <= r1 >> 2;
					r1 <= 10'b0;
					counter1 <= 3'b0;
					f1 <= 1'b1;
				end
				if(f2 == 0 && counter2 == 4) begin //checking whether sum of 4 data was calculated 
					m2 <= r2 >> 2;
					r2 <= 10'b0;
					counter2 <= 3'b0;
					f2 <= 1'b1;
				end
				if(f3 == 0 && counter3 == 4) begin //checking whether sum of 4 data was calculated 
					m3 <= r3 >> 2;
					r3 <= 10'b0;
					counter3 <= 3'b0;
					f3 <= 1'b1;
				end
				if(f4 == 0 && counter4 == 4) begin //checking whether sum of 4 data was calculated 
					m4 <= r4 >> 2;
					r4 <= 10'b0;
					counter4 <= 3'b0;
					f4 <= 1'b1;
				end
				
////////////////////////////////////////////////////////////////////////////////				
				
				if(f1 == 1 && counter1 == 4) begin //checking whether sum of 4 data was calculated 
					w1 <= r1 >> 2;
					r1 <= 10'b0;
					counter1 <= 3'b0;
					f1 <= 1'b0;
				end
				if(f2 == 1 && counter2 == 4) begin //checking whether sum of 4 data was calculated 
					w2 <= r2 >> 2;
					r2 <= 10'b0;
					counter2 <= 3'b0;
					f2 <= 1'b0;
				end
				if(f3 == 1 && counter3 == 4) begin //checking whether sum of 4 data was calculated 
					w3 <= r3 >> 2;
					r3 <= 10'b0;
					counter3 <= 3'b0;
					f3 <= 1'b0;
				end
				if(f4 == 1 && counter4 == 4) begin //checking whether sum of 4 data was calculated 
					w4 <= r4 >> 2;
					r4 <= 10'b0;
					counter4 <= 3'b0;
					f4 <= 1'b0;
				end
				
				diff1 <= (w1 > m1) ? (w1 - m1) : (m1 - w1);
				diff2 <= (w2 > m2) ? (w2 - m2) : (m2 - w2);
				diff3 <= (w3 > m3) ? (w3 - m3) : (m3 - w3);
				diff4 <= (w4 > m4) ? (w4 - m4) : (m4 - w4);
				
				if(diff1 >= 100) begin
					out <= 3'b100;
					out1 <= 2'b00;
					diff1 <= 10'b0;
					w1 <= 10'b0;
					m1 <= 10'b0;
				end
				else if(diff1 >= 50 && diff1 < 100) begin
						out <= 3'b011;
						out1 <= 2'b00;
						diff1 <= 10'b0;
						w1 <= 10'b0;
						m1 <= 10'b0;
				end
				else if(diff1 >= 25 && diff1 < 50) begin
						out <= 3'b010;
						out1 <= 2'b00;
						diff1 <= 10'b0;
						w1 <= 10'b0;
						m1 <= 10'b0;
				end
				else if(diff1 >= 10 && diff1 < 25) begin
						out <= 3'b001;
						out1 <= 2'b00;
						diff1 <= 10'b0;
						w1 <= 10'b0;
						m1 <= 10'b0;
				end
				if(diff2 >= 100) begin
					out <= 3'b100;
					out1 <= 2'b01;
					diff2 <= 10'b0;
					w2 <= 10'b0;
					m2 <= 10'b0;
				end
				else if(diff2 >= 50 && diff2 < 100) begin
						out <= 3'b011;
						out1 <= 2'b01;
						diff2 <= 10'b0;
						w2 <= 10'b0;
						m2 <= 10'b0;
				end
				else if(diff2 >= 25 && diff2 < 50) begin
						out <= 3'b010;
						out1 <= 2'b01;
						diff2 <= 10'b0;
						w2 <= 10'b0;
						m2 <= 10'b0;
				end
				else if(diff2 >= 10 && diff2 < 25) begin
						out <= 3'b001;
						out1 <= 2'b01;
						diff2 <= 10'b0;
						w2 <= 10'b0;
						m2 <= 10'b0;
				end
				if(diff3 >= 100) begin
					out <= 3'b100;
					out1 <= 2'b10;
					diff3 <= 10'b0;
					w3 <= 10'b0;
					m3 <= 10'b0;
				end
				else if(diff3 >= 50 && diff3 <100) begin
						out <= 3'b011;
						out1 <= 2'b10;
						diff3 <= 10'b0;
						w3 <= 10'b0;
						m3 <= 10'b0;
				end
				else if(diff3 >= 25 && diff3 <50) begin
						out <= 3'b010;
						out1 <= 2'b10;
						diff3 <= 10'b0;
						w3 <= 10'b0;
						m3 <= 10'b0;
				end
				else if(diff3 >= 10 && diff3 <25) begin
						out <= 3'b001;
						out1 <= 2'b10;
						diff3 <= 10'b0;
						w3 <= 10'b0;
						m3 <= 10'b0;
				end
				if(diff4 >= 100) begin
					out <= 3'b100;
					out1 <= 2'b11;
					diff4 <= 10'b0;
					w4 <= 10'b0;
					m4 <= 10'b0;
				end
				else if(diff4 >= 50 && diff4 <100) begin
						out <= 3'b011;
						out1 <= 2'b11;
						diff4 <= 10'b0;
						w4 <= 10'b0;
						m4 <= 10'b0;
				end
				else if(diff4 >= 25 && diff4 <50) begin
						out <= 3'b010;
						out1 <= 2'b11;
						diff4 <= 10'b0;
						w4 <= 10'b0;
						m4 <= 10'b0;
				end
				else if(diff4 >= 10 && diff4 <25) begin
						out <= 3'b001;
						out1 <= 2'b11;
						diff4 <= 10'b0;
						w4 <= 10'b0;
						m4 <= 10'b0;
				end	
				
			end
			
								
	end	
endmodule	
