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
    ADD4 A1(A[3:0],   B[3:0],   Cin,   S[3:0],   Co[0]);
    ADD4 A2(A[7:4],   B[7:4],   Co[0], S[7:4],   Co[1]);
    ADD4 A3(A[11:8],  B[11:8],  Co[1], S[11:8],  Co[2]);
    ADD4 A4(A[15:12], B[15:12], Co[2], S[15:12], Cout);
    
endmodule

module ADD4(
    input [3:0] A,
    input [3:0] B,
    input Cin,
    output [3:0] S,
    output Cout
    );
    wire [2:0] Co;
    FADDER A1(S[0], Co[0], A[0], B[0],  Cin  );
    FADDER A2(S[1], Co[1], A[1], B[1],  Co[0]);
    FADDER A3(S[2], Co[2], A[2], B[2],  Co[1]);
    FADDER A4(S[3], Cout,  A[3], B[3],  Co[2]);
endmodule

module FADDER(output S, Cout, input A, B, Cin);
    wire s1, c1, c2;
    assign s1 = A ^ B;
    assign S = s1 ^ Cin;
    assign c1 = A & B;
    assign c2 = Cin & s1;
    assign Cout = c1 | c2;
endmodule
