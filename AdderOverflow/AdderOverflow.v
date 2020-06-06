/********************************************************************
 * Author: Andrew Douglass
 * Date: Feb 18, 2019
 * File: AdderOverflow.v
 *
 * Description: This module performs the addition of the two inputs 
 *              A and B and places the result in signal "result". It 
 *              will perform overflow detection (overflow is active 
 *              high) and will saturate the output to either the 
 *              maximum positive of negative value if an overflow 
 *              occurs. 
 *
 *******************************************************************/

module AdderOverflow ( result, overflow, in_a, in_b );

// Width of the signed data 
parameter DATA_WIDTH = 16;
// Maximum value that the inputs and result can represent 
parameter MAX_VALUE = (2 ** (DATA_WIDTH-1)) - 1;

// Define the input and output ports
output signed [DATA_WIDTH-1:0] result;       // Addition result 
output overflow;                             // High if overflow occurs
input signed [DATA_WIDTH-1:0] in_a;          // First operand
input signed [DATA_WIDTH-1:0] in_b;          // Second operand

// Internal signal to hold potentially incorrect addition 
wire signed [DATA_WIDTH-1:0] summation;

// Perform the addition operation 
assign summation = in_a + in_b;

// An overflow in the addition occurs if the signs of the operands 
// are the same but the sign of the summation does not match the 
// input operand signs 
assign overflow = ((in_a[DATA_WIDTH-1] == in_b[DATA_WIDTH-1]) & (summation[DATA_WIDTH-1] != in_a[DATA_WIDTH-1]));

// If an overflow occurred then saturate the value to the largest 
// negative (if input operands were negative) or positive (if input 
// operands were positive) value that result can hold
assign result = (overflow) ? ( (in_a[DATA_WIDTH-1]) ? -(MAX_VALUE+1) : MAX_VALUE ) : summation;

endmodule 
