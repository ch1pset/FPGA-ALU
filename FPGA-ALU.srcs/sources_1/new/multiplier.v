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

// module Mul_16bit(
//     input [15:0] Multiplicand, Multiplier,
//     input CLK,
//     input EN, START,
//     output reg [31:0] Product = 32'h00000000
//     );
//     reg [1:0] cur_state = 2'b00;
//     reg [15:0] A, B;
//     always@(posedge CLK)
//     begin
//         if(EN) begin
//             case(cur_state)
//             2'b00: begin
//                 A = Multiplicand;
//                 B = Multiplier;
//                 Product = 32'h00000000;
//                 cur_state = 2'b01;
//             end
//             2'b01: begin
//                 if(B > 0) begin
//                     Product = Product + A;
//                     B = B - 1;
//                     cur_state = 2'b01;
//                 end
//                 else begin
//                     cur_state = {~EN, ~START};
//                 end
//             end
//             endcase
//         end
//     end
// endmodule

module mul_16bit(
    input [15:0] A, B,
    output [31:0] product
    );
    wire [15:0] partial [15:0];
    mul_and16 m0( A, B[0],  partial[0]);
    mul_and16 m1( A, B[1],  partial[1]);
    mul_and16 m2( A, B[2],  partial[2]);
    mul_and16 m3( A, B[3],  partial[3]);
    mul_and16 m4( A, B[4],  partial[4]);
    mul_and16 m5( A, B[5],  partial[5]);
    mul_and16 m6( A, B[6],  partial[6]);
    mul_and16 m7( A, B[7],  partial[7]);
    mul_and16 m8( A, B[8],  partial[8]);
    mul_and16 m9( A, B[9],  partial[9]);
    mul_and16 m10(A, B[10], partial[10]);
    mul_and16 m11(A, B[11], partial[11]);
    mul_and16 m12(A, B[12], partial[12]);
    mul_and16 m13(A, B[13], partial[13]);
    mul_and16 m14(A, B[14], partial[14]);
    mul_and16 m15(A, B[15], partial[15]);

    wire [31:0] result [7:0];
    assign result[0] = {16'h0000, partial[0]}            + {15'h000, partial[1],  1'b0};
    assign result[1] = {14'h000,  partial[2],  2'b00}    + {13'h000, partial[3],  3'b000};
    assign result[2] = {12'h000,  partial[4],  4'h0}     + {11'h000, partial[5],  5'h00};
    assign result[3] = {10'h000,  partial[6],  6'h00}    + {9'h000,  partial[7],  7'h00};
    assign result[4] = {8'h00,    partial[8],  8'h00}    + {7'h00,   partial[9],  9'h00};
    assign result[5] = {6'h00,    partial[10], 10'h000}  + {5'h00,   partial[11], 11'h000};
    assign result[6] = {4'h0,     partial[12], 12'h000}  + {3'h0,    partial[13], 13'h0000};
    assign result[7] = {2'b00,    partial[14], 14'h0000} + {1'b0,    partial[15], 15'h0000};
    
    assign product = result[0] + result[1] + result[2] + result[3] + result[4] + result[5] + result[6] + result[7];
endmodule

module mul_and16(
    input [15:0] A,
    input B,
    output [15:0] result
    );
    assign result [0] =  A[0]  & B;
    assign result [1] =  A[1]  & B;
    assign result [2] =  A[2]  & B;
    assign result [3] =  A[3]  & B;
    assign result [4] =  A[4]  & B;
    assign result [5] =  A[5]  & B;
    assign result [6] =  A[6]  & B;
    assign result [7] =  A[7]  & B;
    assign result [8] =  A[8]  & B;
    assign result [9] =  A[9]  & B;
    assign result [10] = A[10] & B;
    assign result [11] = A[11] & B;
    assign result [12] = A[12] & B;
    assign result [13] = A[13] & B;
    assign result [14] = A[14] & B;
    assign result [15] = A[15] & B;
endmodule
