/*	toolkit.v
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
 
module freq_div #(parameter PERIOD=6000,
					parameter PERIOD_WIDTH=12) (input clk, output reg clk_1khz);
    reg [PERIOD_WIDTH:0] count = 0;
    always @(posedge clk)
     begin
        if(count == PERIOD)
            begin
                clk_1khz <= ~clk_1khz;
                count <= 0;
            end
        else
            count <= count + 1;
     end
endmodule

module pos_edge_det ( input sig, input clk, output pe);

    reg   sig_dly;

	always @ (posedge clk) begin
		sig_dly <= sig;
	end

	assign pe = sig & ~sig_dly;
endmodule
