`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/20/2019 11:32:25 PM
// Design Name: 
// Module Name: mul16
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

module Mul_16bit(
    input [15:0] Multiplicand, Multiplier,
    input CLK,
    input EN, START,
    output reg [31:0] Product = 32'h00000000
    );
    reg [1:0] cur_state = 2'b00;
    reg [15:0] A, B;
    always@(posedge CLK)
    begin
        if(EN) begin
            case(cur_state)
            2'b00: begin
                A = Multiplicand;
                B = Multiplier;
                Product = 32'h00000000;
                cur_state = 2'b01;
            end
            2'b01: begin
                if(B > 0) begin
                    Product = Product + A;
                    B = B - 1;
                    cur_state = 2'b01;
                end
                else begin
                    cur_state = {~EN, ~START};
                end
            end
            endcase
        end
    end
endmodule
