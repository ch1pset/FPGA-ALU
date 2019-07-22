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
    input BTNR,
    input BTND,
    input BTNL,
    input BTNC,
    input [15:0] SW,
    output [15:0] LED,
    output [7:0] CA,
    output [7:0] AN
    );
    wire TICK;
    reg [3:0] INSTR;
    reg shr_en;
    reg DISP_EN;

    reg [15:0] A, B;
    reg [31:0] NUMBER;
    wire [31:0] prod_w;
    wire [31:0] sum_w;
    wire [31:0] diff_w;
    wire [31:0] shr_w;

    initial
    begin
        DISP_EN = 1;
        INSTR = 4'h0;
        A = 16'h00ff;
        B = 16'h00ff;
        NUMBER = 32'h00000000;
    end

    // reg [31:0] A = 32'h01234567;
    REFRESH DISP(NUMBER, CLK100MHZ, DISP_EN, CA, AN);
    SLOWCLK SLOW(CLK100MHZ, TICK);

    mul_16bit      MUL_0(A, B, prod_w);
    myadd_alu      ADD_0(A, B, 0, sum_w[15:0], sum_w[16]);
    mysubtr_alu    SUB_0(A, B, 0, diff_w[15:0], diff_w[16]);
    myshft_rt_alu  SHR_0(A, 1, 0, shr_en, shr_w[15:0]);
    
    always@(posedge TICK)
    begin
        if(BTNC)
            DISP_EN = 0;
        else
            DISP_EN = 1;

        case(SW[1:0])
            2'b00: begin
                INSTR = 4'h8;
            end
            2'b01: begin
                INSTR = 4'h4;
            end
            2'b10: begin
                INSTR = 4'h2;
            end
            2'b11: begin
                INSTR = 4'h1;
            end
        endcase
    end

    always@(INSTR)
    begin
        case(INSTR)
            4'h1: NUMBER = prod_w;
            4'h2: NUMBER = shr_w;
            4'h4: NUMBER = diff_w;
            4'h8: NUMBER = sum_w;
        endcase
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
