`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2023 06:00:13 PM
// Design Name: 
// Module Name: uart_tx_tb
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
module uart_tx_tb;

reg clk, txck, rst, tstart;
reg [7:0] txpd;
wire txsd;
wire [3:0] state;

    always #10 txck= ~txck;
    always #5 clk= ~clk;
    
    initial begin
        rst = 0;
        clk=0;
        txck=0;
        tstart =0;
        txpd = 8'h3a;
        #1 rst=1;
        #1 rst=0;
        #20 tstart =1;         
        #20 tstart=0;
        txpd = 8'hff;
        #250
        tstart =0;
        #20
        tstart =1;
        #20
        tstart =0;
        txpd = 8'h8f;
        #250
        tstart =1;

    end
    
    uart_tx aa(txpd,tstart, txck, clk, rst,txsd,state);
    
    endmodule
    
    
    
    
    
    
    
  
