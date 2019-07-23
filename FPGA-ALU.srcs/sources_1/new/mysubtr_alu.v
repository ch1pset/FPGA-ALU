`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/20/2019 09:46:01 PM
// Design Name: 
// Module Name: mysubtr_alu
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


module full_subtractor (a,b,cin,SUB,borrow);
    input a,b,cin;
    output SUB, borrow;
    assign SUB=a^b^cin;
    assign borrow=((~a) & b) | (b & cin) | (cin & (~a));
endmodule

module mysubtr_alu(
    input[15:0]a,b,
    input cin,
    output [15:0]SUB,
    output borrow
);
    wire [14:0]c;
    full_subtractor U1(a[0],b[0],cin,SUB[0],c[0]);
    full_subtractor U2(a[1],b[1],c[0],SUB[1],c[1]);
    full_subtractor U3(a[2],b[2],c[1],SUB[2],c[2]);
    full_subtractor U4(a[3],b[3],c[2],SUB[3],c[3]);
    full_subtractor U5(a[4],b[4],c[3],SUB[4],c[4]);
    full_subtractor U6(a[5],b[5],c[4],SUB[5],c[5]);
    full_subtractor U7(a[6],b[6],c[5],SUB[6],c[6]);
    full_subtractor U8(a[7],b[7],c[6],SUB[7],c[7]);
    full_subtractor U9(a[8],b[8],c[7],SUB[8],c[8]);
    full_subtractor U10(a[9],b[9],c[8],SUB[9],c[9]);
    full_subtractor U11(a[10],b[10],c[9],SUB[10],c[10]);
    full_subtractor U12(a[11],b[11],c[10],SUB[11],c[11]);
    full_subtractor U13(a[12],b[12],c[11],SUB[12],c[12]);
    full_subtractor U14(a[13],b[13],c[12],SUB[13],c[13]);
    full_subtractor U15(a[14],b[14],c[13],SUB[14],c[14]);
    full_subtractor U16(a[15],b[15],c[14],SUB[15],borrow);
endmodule
