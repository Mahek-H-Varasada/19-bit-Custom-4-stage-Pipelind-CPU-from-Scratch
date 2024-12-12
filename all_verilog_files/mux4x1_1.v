module mux4x1_1(
input [7:0]d0,
input [7:0]d1,
input [7:0]d2,
input [7:0]d3,
input [1:0]s,
output [7:0]y
);

assign y= ((s==2'b00)? d0:(((s==2'b01)? d1:((s==2'b10)? d2:d3))));

endmodule
