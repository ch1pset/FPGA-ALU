`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/20/2019 08:08:38 PM
// Design Name: 
// Module Name: myadd_alu
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


module full_adder (a,b,cin,SUM,cout);
    input a,b,cin;
    output SUM, cout;
    assign SUM=a^b^cin;
    assign cout=(a&b)|(a&cin)|(b&cin);
endmodule

module myadd_alu(
    input[15:0]a,b,
    input cin,
    output [15:0]SUM,
    output cout
);
    wire [14:0]c;
    full_adder U1(a[0],b[0],cin,SUM[0],c[0]);
    full_adder U2(a[1],b[1],c[0],SUM[1],c[1]);
    full_adder U3(a[2],b[2],c[1],SUM[2],c[2]);
    full_adder U4(a[3],b[3],c[2],SUM[3],c[3]);
    full_adder U5(a[4],b[4],c[3],SUM[4],c[4]);
    full_adder U6(a[5],b[5],c[4],SUM[5],c[5]);
    full_adder U7(a[6],b[6],c[5],SUM[6],c[6]);
    full_adder U8(a[7],b[7],c[6],SUM[7],c[7]);
    full_adder U9(a[8],b[8],c[7],SUM[8],c[8]);
    full_adder U10(a[9],b[9],c[8],SUM[9],c[9]);
    full_adder U11(a[10],b[10],c[9],SUM[10],c[10]);
    full_adder U12(a[11],b[11],c[10],SUM[11],c[11]);
    full_adder U13(a[12],b[12],c[11],SUM[12],c[12]);
    full_adder U14(a[13],b[13],c[12],SUM[13],c[13]);
    full_adder U15(a[14],b[14],c[13],SUM[14],c[14]);
    full_adder U16(a[15],b[15],c[14],SUM[15],cout);
endmodule