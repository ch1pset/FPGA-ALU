`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/19/2019 01:41:13 PM
// Design Name: 
// Module Name: display
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


module DISPLAY(
    input [31:0] NUM,
    input INCLK,
    output [7:0] SSEG_CA,
    output [7:0] SSEG_AN
    );
    reg [2:0] TICK = 0; // 16 ms per frame = 60
    reg [7:0] POS = 8'h01;
    reg [2:0] COUNT = 2'b00;
    wire CLK;
    
    DISPCLK DCLK(INCLK, CLK);
    
    DIGIT D1(NUM[3*COUNT +: 4], POS, TICK, SSEG_CA, SSEG_AN);
    
    always@(posedge CLK)
    begin
        TICK = TICK + 1;
    end
    
    always@(posedge TICK[2])
    begin
        COUNT = COUNT + 1;
        case(POS)
            8'h80: POS = 8'h01;
            default: POS = (POS << 1);
        endcase
    end
    
endmodule

module DISPCLK(
    input INCLK,
    output reg OUTCLK = 0
    );
    reg [31:0] slow;
    always@(posedge INCLK) // 50 000 000 in 1 sec
    begin
        if(slow < 50000) // 50 000 in 1 ms
            slow = slow + 1;
        else begin
            slow = 32'h00000000;
            OUTCLK = ~OUTCLK; // tick every 1 ms
        end
    end
endmodule

module DIGIT(
    input [3:0] BIN,
    input [7:0] POS,
    input EN,
    output reg [7:0] SSEG_CA,
    output reg [7:0] SSEG_AN
    );
//    POS_SELECT SEL(POS, EN, SSEG_AN);
    always@(posedge EN)
    begin
        SSEG_AN = POS;
        case(BIN)
            4'h0: SSEG_CA = 8'b11111100;
            4'h1: SSEG_CA = 8'b01100000;
            4'h2: SSEG_CA = 8'b11011010;
            4'h3: SSEG_CA = 8'b11110010;
            4'h4: SSEG_CA = 8'b01100110;
            4'h5: SSEG_CA = 8'b10110110;
            4'h6: SSEG_CA = 8'b10111110;
            4'h7: SSEG_CA = 8'b11100000;
            4'h8: SSEG_CA = 8'b11111110;
            4'h9: SSEG_CA = 8'b11110110;
            4'hA: SSEG_CA = 8'b11101110;
            4'hB: SSEG_CA = 8'b00111110;
            4'hC: SSEG_CA = 8'b10011100;
            4'hD: SSEG_CA = 8'b01111010;
            4'hE: SSEG_CA = 8'b10011110;
            4'hF: SSEG_CA = 8'b10001110;
        endcase
    end
endmodule

//module POS_SELECT(
//    input [7:0] POS,
//    input EN,
//    output reg [7:0] SSEG_AN
//    );
//    always@(posedge EN)
//    begin
//        case(POS)
//            3'o0: SSEG_AN = 8'h01;
//            3'o1: SSEG_AN = 8'h02;
//            3'o2: SSEG_AN = 8'h04;
//            3'o3: SSEG_AN = 8'h08;
//            3'o4: SSEG_AN = 8'h10;
//            3'o5: SSEG_AN = 8'h20;
//            3'o6: SSEG_AN = 8'h40;
//            3'o7: SSEG_AN = 8'h80;
//        endcase
//    end
//endmodule