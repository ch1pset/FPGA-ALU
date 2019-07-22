`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/22/2019 10:59:19 AM
// Design Name: 
// Module Name: tb_add_alu
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


module tb_add_alu( );
    reg [15:0] A, B;
    wire [15:0] sum;
    wire carry;

    myadd_alu A0(A, B, 0, sum, carry);
    
endmodule
