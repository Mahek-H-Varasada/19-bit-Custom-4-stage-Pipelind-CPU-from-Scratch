module program_counter #(parameter width = 8)
(input clk,
input [width-1:0]pc,
output reg [width-1:0] pcf);
initial
begin
   pcf=8'b00000000;
end

always@(posedge clk)
 begin
  pcf<=pc;
 end 
 
endmodule 