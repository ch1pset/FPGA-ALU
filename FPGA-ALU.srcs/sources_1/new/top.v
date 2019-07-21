`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/19/2019 04:00:50 PM
// Design Name: 
// Module Name: top
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


module DISP(
    input CLK100MHZ,
    input BTNU,
    input BTNC,
    input BTND,
    input [15:0] SW,
    output [15:0] LED,
    output [7:0] CA,
    output [7:0] AN
    );
    wire TICK;
    reg DISP_EN = 1;
    reg [31:0] A = 32'h01234567;
    REFRESH DISP(A, CLK100MHZ, DISP_EN, CA, AN);
    SLOWCLK SLOW(CLK100MHZ, TICK);
    
    always@(posedge TICK)
    begin
        if(BTNC)
            DISP_EN = 0;
        else
            DISP_EN = 1;
            
        if(BTNU)
            A = 32'h01234567;
        else if(BTND)
            A = 32'h89ABCDEF;
    end
endmodule

module SLOWCLK(
    input INCLK,
    output reg CLK
    );
    reg [31:0] slow;
    always@(posedge INCLK)
    begin
        if(slow < 10000000)
            slow = slow + 1;
        else begin
            slow = 32'h00000000;
            CLK = ~CLK; // tick every 1 ms
        end
    end
endmodule
