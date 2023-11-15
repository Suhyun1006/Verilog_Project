`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/14/2023 05:29:10 PM
// Design Name: 
// Module Name: uart_tx
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


module uart_tx( 
input [7:0] txpd, 
input tstart, txck, clk, rst,
output txsd, output reg [3:0] state
    );
    
    reg [3:0] next;
    reg [7:0] buffer;
      
    always@(*)begin
    case(state)
    4'd0: begin next <= (tstart)? 4'd1: 4'd0; buffer <=txpd; end
    4'd1: next <= state+4'd1; //stater
    4'd2: next <= state+4'd1; //D1
    4'd3: next <= state+4'd1;
    4'd4: next <= state+4'd1;
    4'd5: next <= state+4'd1;
    4'd6: next <= state+4'd1;
    4'd7: next <= state+4'd1;
    4'd8: next <= state+4'd1;
    4'd9: next<= state+4'd1;
    4'd10: next <= (tstart)? 4'd1: 4'd0; //Stop
    default : next<=4'd0;
    endcase
    end
    
    always@(posedge txck, posedge rst)begin
    if(rst) state <= 4'd0;
    else  state <= next;
    end
    
    assign txsd = (state ==4'd0)? 1: 
                    (state ==4'd1)? 0:  
                    (state ==4'd2)?buffer[0]:
                    (state ==4'd3)?buffer[1]:
                    (state ==4'd4)?buffer[2]:
                    (state ==4'd5)?buffer[3]:
                    (state ==4'd6)?buffer[4]:
                    (state ==4'd7)?buffer[5]:
                    (state ==4'd8)?buffer[6]:
                    (state ==4'd9)?buffer[7]:
                    (state ==4'd10)?1:1;
endmodule
