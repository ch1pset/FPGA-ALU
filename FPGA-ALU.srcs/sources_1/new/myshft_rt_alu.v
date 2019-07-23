`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/20/2019 09:47:04 PM
// Design Name: 
// Module Name: myshft_rt_alu
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


module myshft_rt_alu(in_data, clk, en, out_data);
    input [15:0] in_data;
    input clk, en;
    output reg [15:0] out_data;

    always@(posedge clk)
    begin
        if(en) begin
            out_data[0]  <= in_data[1];
            out_data[1]  <= in_data[2];
            out_data[2]  <= in_data[3];
            out_data[3]  <= in_data[4];
            out_data[4]  <= in_data[5];
            out_data[5]  <= in_data[6];
            out_data[6]  <= in_data[7];
            out_data[7]  <= in_data[8];
            out_data[8]  <= in_data[9];
            out_data[9]  <= in_data[10];
            out_data[10] <= in_data[11];
            out_data[11] <= in_data[12];
            out_data[12] <= in_data[13];
            out_data[13] <= in_data[14];
            out_data[14] <= in_data[15];
            out_data[15] <= 0;
        end
        else out_data <= in_data;
    end    
endmodule
