/*	receiver.v
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

module receiver(clk, signal, detect, l_right, l_left);
	output l_right, l_left;
	output wire [7:0] detect;
	input clk, signal;
	
	wire [7:0] aux;
	wire [7:0] average;
	wire error;
	//assign detect = error? 8'b11000011 : {aux, clk_1khz, signal};
	assign detect = {average[7:3], l_right, l_left, ~signal} | {8{error}};
	
	wire edge_signal;
	pos_edge_det ped(signal, clk_1khz, edge_signal);
	freq_div #(30000, 15) div(clk, clk_1khz);
	
	signal_comparator cmp(.clk(clk_1khz), .signal(signal), .detect(aux), .error(error), .edge_signal(edge_signal));
	signal_filter filter(signal, aux, average);
	//signal_filter filter(clk_1khz, signal, aux, average);
	obturador ob(clk_1khz, edge_signal, average, l_right, l_left);

endmodule

module obturador(clk, edge_signal, cycle, right, left);
	output right, left;
	input clk, edge_signal;
	input wire [7:0] cycle;
	
	reg [7:0] count = 0;
	assign right = count < {1'b0, cycle[7:1]}? 1: 0;
	assign left = ~right;
	
	always @(posedge clk)
	if((count == cycle) || (edge_signal))
		count <= 0;
	else
		count <= count +1;

endmodule

