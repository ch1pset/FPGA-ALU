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
    reg MUL, ADD, SHFT, SUB;
    reg DISP_EN = 1;

    reg [15:0] A, B;
    reg [31:0] NUMBER;
    wire [31:0] prod_w;

    // reg [31:0] A = 32'h01234567;
    REFRESH DISP(NUMBER, CLK100MHZ, DISP_EN, CA, AN);
    SLOWCLK SLOW(CLK100MHZ, TICK);

    mul_16bit m0(A, B, prod_w);
    
    always@(posedge TICK)
    begin
        if(BTNC)
            DISP_EN = 0;
        else
            DISP_EN = 1;
            
        if(BTNU)
            NUMBER = prod_w;

        case(SW[1:0])
        2'b00: begin
            ADD = 0;
            SUB = 0;
            SHFT = 0;
            MUL = 1;
        end
        endcase
    end

    always@(posedge MUL)
    begin
        A = 16'h00ff;
        B = 16'h00ff;
        MUL = 0;
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
