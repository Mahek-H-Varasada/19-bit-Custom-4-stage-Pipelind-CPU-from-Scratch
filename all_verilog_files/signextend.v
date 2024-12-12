module signextend(input [7:0] a, output [18:0] b);

// Zero extension: pad the upper 11 bits with zeros.
assign b = {{11{a[7]}}, a};

endmodule