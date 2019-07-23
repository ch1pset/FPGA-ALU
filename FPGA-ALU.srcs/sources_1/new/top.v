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
    input [4:0] SW,
    output [7:0] CA,
    output [7:0] AN,
    output reg [4:0] LED
    );
    wire TICK;
    reg display_en;

    // reg [15:0] A, B;
    reg [31:0] display_data;
    wire [31:0] data_bus;
    wire [15:0] A, B;
    wire [4:0] led_w;

    initial
    begin
        display_en = 1;
        display_data = {A, B};
    end

    REFRESH     DISP(display_data, CLK100MHZ, display_en, CA, AN);
    SLOWCLK     SLOW(CLK100MHZ, 2500000, TICK);
    ALU         ALU0(SW[1:0], TICK, BTNC, SW[4], A, B, data_bus, led_w);

    CountReg    A_reg(TICK, SW[4], SW[3], BTNU, BTNR, A);
    CountReg    B_reg(TICK, SW[4], SW[3], BTNL, BTND, B);
    
    always@(posedge TICK)
    begin
        display_data = data_bus;
        LED = led_w;
    end
endmodule

module CountReg(
    input CLK, EN, RST, INC, DEC,
    output reg [15:0] DO = 16'h0000
    );
    always@(posedge CLK)
    begin
        if(EN)
            case({DEC, INC})
                2'b01: DO = DO + 1;
                2'b10: DO = DO - 1;
            endcase
        if(RST)
            DO = 16'h0000;
    end
endmodule

module ALU(
    input [1:0] OPCODE,
    input CLK,
    input EN,
    input RST,
    input [15:0] D0, D1,
    output reg [31:0] Data,
    output reg [4:0] led_o
    );
    wire [31:0] prod_bus, sum_bus, diff_bus, shr_bus;

    initial
    begin
        Data = 32'h00000000;
    end

    mul_16bit       MUL_0(D0, D1, prod_bus);
    myadd_alu       ADD_0(D0, D1, 0, sum_bus[15:0], sum_bus[16]);
    mysubtr_alu     SUB_0(D0, D1, 0, diff_bus[15:0], diff_bus[16]);
    myshft_rt_alu   SHR_0(D0, CLK, EN, shr_bus[15:0]);

    always@(posedge CLK)
    begin
        case({RST, OPCODE[1:0]})
            3'b000: begin
                Data <= sum_bus;
                led_o <= 5'h1;
            end
            3'b001: begin
                Data <= diff_bus;
                led_o <= 5'h2;
            end
            3'b010: begin
                Data <= prod_bus;
                led_o <= 5'h4;
            end
            3'b011: begin
                Data <= shr_bus;
                led_o <= 5'h8;
            end
            3'b100: begin
                Data <= {D0, D1};
                led_o <= 5'h10;
            end
            default: begin
                Data <= {D0, D1};
            end
        endcase
    end

endmodule

module SLOWCLK(
    input INCLK,
    input [31:0] th_us,
    output reg CLK
    );
    reg [31:0] slow;
    always@(posedge INCLK)
    begin
        if(slow < th_us)
            slow <= slow + 1;
        else begin
            slow = 32'h00000000;
            CLK <= ~CLK; // tick every 1 ms
        end
    end
endmodule
