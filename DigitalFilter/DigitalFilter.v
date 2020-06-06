/********************************************************************
 * 
 * Author: Andrew Douglass
 * Date: June 6, 2020
 * File: DigitalFilter.v
 *
 * Description: This module filters the input signal based on the 
 *              specified filter size. All pulses that are up to 
 *              FILTER_SIZE clock pulses long will be removed. 
 *              Below is an example waveform with FILTER_SIZE = 2.
 *                     _   _   _   _   _   _   _   _   _   _   _   
 *  clk:             _| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_
 *                           _______             _________________
 *  noisy_signal:    _______|       |___________|                 
 *                                                         _______
 *  filtered_signal: _____________________________________|
 *
 *******************************************************************/

module DigitalFilter ( 
	input clk,        
	input rst_n, 
	input noisy_signal, 
	output reg filtered_signal
); 

// Specify the width of the filter
parameter FILTER_SIZE = 2;

// Temporary register to hold the value of noisy_signal from 
// previous clock cycles
reg [FILTER_SIZE-1:0] tmp; 

always@(posedge clk or negedge rst_n) begin 
	if(rst_n == 0) begin 
		tmp <= 0;
		filtered_signal <= 0;
	end
	else begin 
		// Shift the bits in the temporary register 
		tmp <= (tmp << 1);
		tmp[0] <= noisy_signal;
	
		// Check if the noisy_signal has held low 
		if(|tmp == 0 && noisy_signal == 0) begin 
			filtered_signal <= 0;
		end 
		// Check if the noisy_signal has held high 
		else if(&tmp == 1 && noisy_signal == 1) begin 
			filtered_signal <= 1;
		end 
		else begin 
			filtered_signal <= noisy_signal;
		end 
	end 
end 
	
endmodule 
