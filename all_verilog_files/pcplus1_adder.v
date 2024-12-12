module pcplus1_adder(
input wire [7:0] a,
output wire[7:0] c
);

wire [7:0] b = 8'b00000001;

assign c= a+b;
endmodule