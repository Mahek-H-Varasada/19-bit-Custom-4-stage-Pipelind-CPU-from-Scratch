module instruction_memory(
input [7:0]address,
output [18:0]data
);

reg[18:0]instrmem[255:0];

initial 
begin
$readmemh("instrmemfile_Copy_1.hex",instrmem);
end

assign data = instrmem[address];

endmodule

