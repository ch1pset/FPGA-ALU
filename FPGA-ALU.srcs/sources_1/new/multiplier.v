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

module mul_16bit(
    input [15:0] A, B,
    output [31:0] product
    );
    wire [15:0] partial [15:0];
    assign partial[0] =  {{16{B[0]}}  & A[15:0]};
    assign partial[1] =  {{16{B[1]}}  & A[15:0]};
    assign partial[2] =  {{16{B[2]}}  & A[15:0]};
    assign partial[3] =  {{16{B[3]}}  & A[15:0]};
    assign partial[4] =  {{16{B[4]}}  & A[15:0]};
    assign partial[5] =  {{16{B[5]}}  & A[15:0]};
    assign partial[6] =  {{16{B[6]}}  & A[15:0]};
    assign partial[7] =  {{16{B[7]}}  & A[15:0]};
    assign partial[8] =  {{16{B[8]}}  & A[15:0]};
    assign partial[9] =  {{16{B[9]}}  & A[15:0]};
    assign partial[10] = {{16{B[10]}} & A[15:0]};
    assign partial[11] = {{16{B[11]}} & A[15:0]};
    assign partial[12] = {{16{B[12]}} & A[15:0]};
    assign partial[13] = {{16{B[13]}} & A[15:0]};
    assign partial[14] = {{16{B[14]}} & A[15:0]};
    assign partial[15] = {{16{B[15]}} & A[15:0]};

    wire [31:0] result [7:0];
    assign result[0] = {16'h0000, partial[0]}            + {15'h000, partial[1],  1'h0};
    assign result[1] = {14'h000,  partial[2],  2'h0}     + {13'h000, partial[3],  3'h0};
    assign result[2] = {12'h000,  partial[4],  4'h0}     + {11'h000, partial[5],  5'h00};
    assign result[3] = {10'h000,  partial[6],  6'h00}    + {9'h000,  partial[7],  7'h00};
    assign result[4] = {8'h00,    partial[8],  8'h00}    + {7'h00,   partial[9],  9'h00};
    assign result[5] = {6'h00,    partial[10], 10'h000}  + {5'h00,   partial[11], 11'h000};
    assign result[6] = {4'h0,     partial[12], 12'h000}  + {3'h0,    partial[13], 13'h0000};
    assign result[7] = {2'h0,     partial[14], 14'h0000} + {1'h0,    partial[15], 15'h0000};
    
    assign product = result[0] + result[1] + result[2] + result[3] + result[4] + result[5] + result[6] + result[7];
endmodule
