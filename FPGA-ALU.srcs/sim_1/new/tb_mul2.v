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
    reg CLK = 0, EN = 0, RST = 0;
    wire [31:0] Product;
    
    Mul_16bit M(A, B, CLK, EN, RST, Product);

    initial
    begin
        A = 16'h0000;
        B = 16'h0000;

        #5 A = 16'h0003;
        EN = 1;
        toggleReset();
        #5 B = 16'h0006;
        toggleReset();


    end
    
    always #1 CLK = ~CLK;

    
    task toggleReset;
        begin
            #1 RST = 1;
            #1 RST = 0;
        end
    endtask
endmodule
