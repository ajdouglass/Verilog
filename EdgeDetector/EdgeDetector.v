/********************************************************************
 * Author: Andrew Douglass
 * Date: Feb 22, 2019
 * File: EdgeDetector.v
 *
 * Description: This module detects a rising/falling edge on the 
 *              edge_signal input. The rise_edge signal will strobe 
 *              high when a rising edge is detected and the 
 *              fall_edge signal will strobe high when a falling edge 
 *              is detected. 
 *                 _   _   _   _   _   _   _   _   _   _   _   _ 
 *  clk:         _| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_| |_
 *                           ___________________
 *  edge_signal: ___________|                   |_________________
 *                             ___
 *  rise_edge:   _____________|   |_______________________________
 *                                                 ___
 *  fall_edge:   _________________________________|   |___________
 *
 *******************************************************************/

module EdgeDetector ( 
    input clk,              // System clock 
    input rst_n,            // Active low reset 
    input edge_signal,      // Signal to detect edges on 
    output rise_edge,       // Strobe high for rising edge 
    output fall_edge        // Strobe high for falling edge 
); 

// Store the value of edge_signal on the previous clock cycle
reg prev_edge_signal;

always@(posedge clk or negedge rst_n) begin 
    if(!rst_n) begin 
        prev_edge_signal <= 0; 
        rise_edge <= 0; 
        fall_edge <= 0;
    end 
    else if(edge_signal == 1 && prev_edge_signal == 0) begin 
        // Rising edge was detected 
        prev_edge_signal <= edge_signal;
        rise_edge <= 1;
		fall_edge <= 0;
    end
    else if(edge_signal == 0 && prev_edge_signal == 1) begin 
        // Falling edge was detected 
        prev_edge_signal <= edge_signal; 
        rise_edge <= 0; 
        fall_edge <= 1;
    end 
    else begin 
        // Default case, hold the previous value of the signal 
        prev_edge_signal <= edge_signal;
        rise_edge <= 0;
        fall_edge <= 0;
    end
end

endmodule 
