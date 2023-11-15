/////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/15/2023 10:10:21 AM
// Design Name: 
// Module Name: Uart_tx
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


module Uart_tx_Lec(
    input [7:0] txpd,
    input clk,
    input txck,
    input rst,
    input tstart,
    output reg txsd,
    output reg [3:0] bcnt
    );
    
    reg [7:0] buffer;
    
    reg tx0, tx1;
    reg ts0,ts1;
    wire sten;
    wire tcenr, tcenf, tstr;
    
    // output
    always@(posedge clk, negedge rst)begin
    if(~rst) txsd <= 0;
    else begin
    case(bcnt)
        4'd0: begin txsd <=0; buffer <= txpd; end
        4'd1:txsd <= buffer[0];
        4'd2:txsd <=buffer[1];
        4'd3:txsd <=buffer[2];
        4'd4:txsd <=buffer[3];
        4'd5:txsd <=buffer[4];
        4'd6:txsd <=buffer[5];
        4'd7:txsd <=buffer[6];
        4'd8:txsd <=buffer[7];
        4'd9: txsd<=1  ;
        default:txsd<=1;
    endcase
    end
    end 
    
    //bcnt control
    always@(posedge clk, negedge rst)begin
    if(rst==0)begin
        bcnt<=4'hf;
    end   
    else begin

        if(tcenr)begin
            if(bcnt >=9)begin
                bcnt <= (sten)? 4'h0: 4'hf;
                end 
            else bcnt <= bcnt +1;
        end
    end
    end
    
    //tcen tcnf 
    always@(posedge clk, negedge rst)begin
    if(~rst) begin tx0<=0; tx1<=0; end
    else begin
        tx0 <= txck;
        tx1 <= tx0;
        end
    end  
    
    assign tcenr = tx0 &(~tx1);
    assign tcenf = ~tx0 &(tx1);
   
   //tstart rising endge Detector 
    always@(posedge clk, negedge rst)begin
    if(~rst) begin ts0<=0; ts1<=0; end
    else if(tcenf) begin 
        ts0 <= tstart;
        ts1 <= ts0;
        end
    end  
     
    assign sten = (ts0 &(~ts1))?1:0;
    
    
    // sten making

endmodule
