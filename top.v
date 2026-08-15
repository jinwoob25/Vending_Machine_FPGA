`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/13/2026 07:14:31 PM
// Design Name: 
// Module Name: top
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
module top(
    input clk, rst, raw_signalD, raw_signalQ,
    output [1:0] AP
);
wire signalD, signalQ;
wire edge_signalD, edge_signalQ;
wire new_coin = edge_signalD | edge_signalQ;
wire [1:0] fsm_AP;
reg [25:0] timer_A, timer_P;
debouncer debouncerD (.clk(clk), .rst(rst), .raw_signal(raw_signalD), .clean_signal(signalD));
debouncer debouncerQ (.clk(clk), .rst(rst), .raw_signal(raw_signalQ), .clean_signal(signalQ));

edge_detector detectorD (.clk(clk), .rst(rst), .signal(signalD), .new_coin(edge_signalD));
edge_detector detectorQ (.clk(clk), .rst(rst), .signal(signalQ), .new_coin(edge_signalQ));

FSM u_FSM (.clk(clk), .rst(rst), .T(signalQ), .new_coin(new_coin), .AP(fsm_AP));

always@(posedge clk, posedge rst)begin

    //timer for A
    if(rst)begin
        timer_A <=0;
    end else if (fsm_AP[1]) begin
        timer_A <= 62_500_000;
    end else if (timer_A>0)begin
        timer_A <= timer_A-1;
    end
    //timer for P
    if(rst)begin
        timer_P <=0;
    end else if (fsm_AP[0]) begin
        timer_P <= 62_500_000;
    end else if (timer_P>0)begin
        timer_P <= timer_P-1;
    end
    

end

assign AP[1] = (timer_A > 0);
assign AP[0] = (timer_P > 0);


endmodule

module debouncer(
    input clk, rst, 
    input raw_signal, 
    output reg clean_signal
);
parameter COUNT_MAX = 1_250_000;
reg [20:0] count = 0;
reg sync_0, sync_1; 

always@(posedge clk, posedge rst) begin

    if (rst) begin
        sync_0 <= 1'd0;
        sync_1 <= 1'd0;
    end else begin
        sync_0 <= raw_signal;
        sync_1 <= sync_0;
    
    end
end
// filtering by using counter
always@(posedge clk, posedge rst) begin
    if (rst) begin
        count <= 0;
        clean_signal <= 1'd0;
    end else begin
    // if change is detected
        if (sync_1 != clean_signal) begin
            count <= count + 1;
            //long enough, butten is pressed for sure
            if (count >= COUNT_MAX) begin
            clean_signal <= sync_1;
            count <= 0;
            end
        end else
        //change is not detected
            count <= 0;
        
        
    end

end

endmodule


module edge_detector(
    input clk, rst, signal,
    output new_coin
);
reg delay;
always@(posedge clk, posedge rst)begin
    if (rst)
        delay <= 1'd0;
    else
        delay <= signal;

end

assign new_coin = signal && !delay;
endmodule


module FSM(
input clk, T, rst, new_coin,//T: coin input. T = 0 for dime. T = 1 for quarter
output reg [1:0] AP // MSB A: accept coin. LSB P: paid, give product
    );
reg [2:0]current; //current state
reg [2:0] next; //next state
parameter START = 0;
parameter DIME = 1;
parameter QUARTER = 2;
parameter  REJECTD = 3;
parameter REJECTQ = 4;
parameter PAID = 5;
   
   

   
   
always@(*) begin // next state block
    next = current;
    if (new_coin) begin
        case(current)
        START: begin
            if (T)
                next = QUARTER;
            else
                next = DIME;
        end
        
        DIME: begin
            if (T)
                next = PAID;
            else
                next = REJECTD;
        end
        
        QUARTER: begin
            if (T)
                next = REJECTQ;
            else
                next = PAID;
        end
        
        REJECTD: begin
            if (T)
                next = PAID;
            else
                next = REJECTD;
        end
        
        REJECTQ: begin
            if (T)
                next = REJECTQ;
            else
                next = PAID;
        end
        
        PAID: begin
            if (T)
                next = QUARTER;
            else
                next = DIME;
        end
        
        default: 
            next = START;
        
        endcase
        
                
    end

end




always@(posedge clk, posedge rst) begin //current state update block
    if (rst)
        current <= START;
    else
        current <= next;
end



always@(*) begin // output logic block

    case (current)
    START: 
        AP = 2'b00;
     
        
    DIME: 
        AP = 2'b10;
        
        
    QUARTER: 
        AP = 2'b10;
        
        
    REJECTD: 
        AP = 2'b00;
        
        
    REJECTQ: 
        AP = 2'b00;
        
    PAID: 
        AP = 2'b11;
        
    default:
        AP = 2'b00;
       
        
    endcase
    

end
    
   
endmodule

