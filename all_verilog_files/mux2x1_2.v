module mux2x1_2 #(parameter width = 2)
(input [width-1:0] d0, d1,
input s,
output [width-1:0] y );

assign y=(s==1'b0) ? d0:d1;

endmodule
