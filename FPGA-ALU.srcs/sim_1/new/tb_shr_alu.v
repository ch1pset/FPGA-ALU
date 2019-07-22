`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/22/2019 10:57:32 AM
// Design Name: 
// Module Name: tb_shr_alu
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


module tb_shr_alu( );
    reg [15:0] A;
    reg shr_en;
    wire [15:0] As;

    myshft_rt_alu SHR(A, shr_en, 0, As);

    initial
    begin
        shr_en = 0;
        A = 16'ha5a5;
        #2 shr(4);
        #2 shr(8);
    end

    task shr;
    input reg [3:0] num;
    begin
        while(num > 0)
        begin
            #1 shr_en = 1;
            #1 shr_en = 0;
            A = As;
            num = num - 1;
        end
    end
    endtask
endmodule
