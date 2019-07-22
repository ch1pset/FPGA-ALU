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
    input BTNRST,
    input [15:0] SW,
    output [15:0] LED,
    output [7:0] CA,
    output [7:0] AN
    );
    wire TICK;
    reg display_en;

    reg [15:0] A, B;
    reg [31:0] display_data;
    wire [31:0] data_bus;

    initial
    begin
        display_en = 1;
        A = 16'hf0f0;
        B = 16'h0f0f;
        display_data = {A, B};
    end

    REFRESH DISP(display_data, CLK100MHZ, display_en, CA, AN);
    SLOWCLK SLOW(CLK100MHZ, TICK);
    ALU     A0(SW[1:0], TICK, A, B, BTNRST, BTNU, BTND, BTNL, BTNR, BTNC, data_bus);
    
    always@(posedge TICK)
    begin
        if(BTNC)
            display_en = 0;
        else
            display_en = 1;

        display_data = data_bus;
    end

endmodule

module ALU(
    input [1:0] OPCODE,
    input CLK,
    input [15:0] D1, D2,
    input RST, INC, DEC, LFT, RHT, EVAL,
    output reg [31:0] Dout
    );
    reg [15:0] A, B;
    reg [31:0] Data;
    reg [3:0] INSTR;
    reg SET;
    wire [31:0] prod_bus, sum_bus, diff_bus, shr_bus;

    initial
    begin
        A = 16'h0000;
        B = 16'h0000;
        Data = 32'h00000000;
        INSTR = 4'h0;
        SET = 1;
    end

    mul_16bit       MUL_0(A, B, prod_bus);
    myadd_alu       ADD_0(A, B, 0, sum_bus[15:0], sum_bus[16]);
    mysubtr_alu     SUB_0(A, B, 0, diff_bus[15:0], diff_bus[16]);
    myshft_rt_alu   SHR_0(Dout, shr_en, shr_bus[15:0]);

    always@(posedge CLK)
    begin
        if(RST) begin
            //todo: reset all values
            A = D1;
            B = D2;
        end

        if(INC) begin
            //todo: handle increment

        end

        if(DEC) begin
            //todo: handle decrement
        end

        if(LFT) begin

        end

        if(RHT) begin

        end

        if(EVAL)
            //todo: trigger evaluation
            SET = 1;
        else
            SET = 0;


        case(OPCODE[1:0])
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
            4'h1: Data = prod_bus;
            4'h2: Data = shr_bus;
            4'h4: Data = diff_bus;
            4'h8: Data = sum_bus;
        endcase
    end

    always@(posedge SET)
    begin
        Dout = Data;
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
