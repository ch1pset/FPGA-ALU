`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/20/2019 10:32:16 PM
// Design Name: 
// Module Name: tb_mul2
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


module tb_mul2( );
    reg [15:0] A, B;
    wire [31:0] Product;
    
    mul_16bit M(A, B, Product);

    initial
    begin
        A = 16'h0000;
        B = 16'h0000;

        #5 A = 16'h5a5a;
        #5 B = 16'ha5a5;
        #5 A = 16'h0f0f;
        #5 B = 16'hf0f0;
    end
    

endmodule
