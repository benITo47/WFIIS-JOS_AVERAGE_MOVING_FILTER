`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2025 05:29:53 PM
// Design Name: 
// Module Name: clkdiv
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clkdif #(parameter div=200)(
    input clk,
    input reset,
    output enable
    );

localparam n = $clog2(div);
logic [n-1:0] cnt; 
    
always @(posedge clk, posedge reset)
    if(reset)   
        cnt <= {n{1'b0}};
    else if (cnt == div - 1)
        cnt <= {{1'b0}};
    else 
        cnt <= cnt + 1'b1;


assign enable = (cnt == div -1); 
endmodule
