/*	signal.v
 *  Copyright (C) 2020  Carlos Dominguez
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */
 
module signal_comparator(clk, signal, edge_signal, detect, error);
	output reg [7:0] detect;
	output reg error;
	input clk, signal, edge_signal;
	
	reg [7:0] det = 0;
	
	always @(posedge clk)
		if(edge_signal)
		begin
			detect <= det? det: detect;
			det <= 0;
			error <= 0;
		end
		else if(!error)
		begin
			if(&det)error <= 1;
			det <= det + 1;
		end
endmodule

module signal_filter(signal, detect, average);
	input signal;
	input wire [7:0] detect;
	output wire [7:0] average;
	reg [7:0] mem [15:0];
	reg [3:0] count = 0;
	
	wire [11:0] adder;
	assign adder = mem[0] + mem[1] + mem[2] + mem[3] + mem[4] + mem[5] + mem[6] + mem[7] + mem[8] + mem[9] + mem[10] + mem[11] + mem[12] + mem[13] + mem[14] + mem[15];
	assign average = {5'b00000, adder[11:4]};
	
	always @(posedge signal)
		begin
			if (count == 4'b1111)
				count <= 0;
			else
				count <= count + 1;
			
			mem[count] <= detect;
		end
		
endmodule

/*module signal_filter(clk, signal, detect, average);
	input clk, signal;
	input wire [7:0] detect;
	output reg [7:0] average = 0;
	reg [7:0] mem [15:0];
	reg [3:0] count = 0;
	reg [3:0] count2 = 0;
	reg [11:0] avr = 0;
	
	always @(posedge signal)
		begin
			if (count == 4'b1111)
				count <= 0;
			else
				count <= count + 1;
			
			mem[count] <= detect;
		end
	
	always @(posedge clk)
		begin
			if (count2 == 4'b1111) begin
				count2 <= 0;
				average <= {4'b0000, avr[11:3]};
				avr <= 0;
			end
			else begin
				count2 <= count2 + 1;
				avr <= avr + mem[count2];
			end
		end
endmodule
*/
