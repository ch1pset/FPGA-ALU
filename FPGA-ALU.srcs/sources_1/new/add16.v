`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/19/2019 11:09:18 AM
// Design Name: 
// Module Name: ADD16
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

module ADD16(
    input [15:0] A,
    input [15:0] B,
    input Cin,
    output [15:0] S,
    output Cout
    );
    wire [2:0] Co;
    ADD4 A1(A[0  +:4], B[0  +:4], Cin,   S[0  +:4], Co[0]);
    ADD4 A2(A[4  +:4], B[4  +:4], Co[0], S[4  +:4], Co[1]);
    ADD4 A3(A[8  +:4], B[8  +:4], Co[1], S[8  +:4], Co[2]);
    ADD4 A4(A[12 +:4], B[12 +:4], Co[2], S[12 +:4], Cout);
    
endmodule

module ADD4(
    input [3:0] A,
    input [3:0] B,
    input Cin,
    output [3:0] S,
    output Cout
    );
    wire [2:0] Co;
    FADDER A1(A[0], B[0],  Cin  , S[0], Co[0]);
    FADDER A2(A[1], B[1],  Co[0], S[1], Co[1]);
    FADDER A3(A[2], B[2],  Co[1], S[2], Co[2]);
    FADDER A4(A[3], B[3],  Co[2], S[3],  Cout);
endmodule

module FADDER(input A, B, Cin, output S, Cout);
    wire s1, c1, c2;
    assign s1 = A ^ B;
    assign S = s1 ^ Cin;
    assign c1 = A & B;
    assign c2 = Cin & s1;
    assign Cout = c1 | c2;
endmodule
