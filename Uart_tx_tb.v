`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2023 11:16:27 AM
// Design Name: 
// Module Name: Uart_tx_tb
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


module Uart_tx_tb;
reg clk, txck, rst, tstart;
reg [7:0] txpd;
wire txsd;
wire [3:0] bcnt;

    always #10 txck= ~txck;
    always #2 clk= ~clk;
    
    initial begin
        rst = 1;
        clk=0;
        txck=0;
        tstart =0;
        txpd = 8'h3a;
        #8 rst=0;
        #12 rst=1;
        #20 tstart =1;         
        #20 tstart=0;
        #20 txpd = 8'hff;
        #250
        tstart =0;
        #20
        tstart =1;
        #20
        tstart =0;
        #20 txpd = 8'h8f;
        #250
        tstart =1;

    end
   
    Uart_tx_Lec aa(txpd,clk,txck,rst,tstart,txsd,bcnt);
    
    endmodule