`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/15/2026 01:32:25 PM
// Design Name: 
// Module Name: tb_top
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


module tb_top();

reg clk, rst, raw_signalD, raw_signalQ;
wire [1:0] AP;
top uut(.clk(clk), .rst(rst), .raw_signalD(raw_signalD), .raw_signalQ(raw_signalQ), .AP(AP));

always #4 clk = ~clk; //period 8ns, 125MHz
initial begin

    clk = 0;
    rst = 1;
    raw_signalD = 0;
    raw_signalQ = 0;

    #100;
    rst = 0;
    #100;
    
    raw_signalQ = 1;
    #5000;
    raw_signalQ = 0;
    #10000;
    
    
    raw_signalQ = 1;
    #5000;
    raw_signalQ = 0;
    #10000;
    
    
    raw_signalQ = 1;
    #5000;
    raw_signalQ = 0;
    #10000;
    
    
    raw_signalD = 1;
    #5000;
    raw_signalD = 0;
    #10000;
    
    
    raw_signalQ = 1;
    #5000;
    raw_signalQ = 0;
    #10000;
    
    
    raw_signalD = 1;
    #5000;
    raw_signalD = 0;
    #10000;
    
    
    raw_signalD = 1;
    #5000;
    raw_signalD = 0;
    #10000;
    
    
    raw_signalQ = 1;
    #5000;
    raw_signalQ = 0;
    #10000;
    
    
    raw_signalD = 1;
    #5000;
    raw_signalD = 0;
    #10000;
    
    
    raw_signalD = 1;
    #5000;
    raw_signalD = 0;
    #10000;
    
    
    raw_signalD = 1;
    #5000;
    raw_signalD = 0;
    #10000;
    
    
    raw_signalQ = 1;
    #5000;
    raw_signalQ = 0;
    #10000;
    
    
    raw_signalQ = 1;
    #5000;
    raw_signalQ = 0;
    #10000;
    
    
    rst = 1;
    #5000;
    rst = 0;
    #10000;


    raw_signalD = 1;
    #5000;
    raw_signalD = 0;
    #10000;
    
    $finish;
    

end


endmodule
