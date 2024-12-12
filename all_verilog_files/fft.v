module fft(
    input wire clk,
    input wire rst,
    input wire [15:0] in, 
    output reg [15:0] out
);

    // Internal registers for input and intermediate values
    reg signed [3:0] x [0:3]; // Signed real parts of inputs
    reg signed [15:0] temp [0:3]; // Intermediate real results

    integer i;

    // Unpack inputs into signed real arrays
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < 4; i = i + 1) begin
                x[i] <= 4'sb0;  // Initialize to signed 0
            end
        end else begin
            x[0] <= $signed(in[15:12]);  // Sign-extend the 4-bit input
            x[1] <= $signed(in[11:8]);   // Sign-extend the 4-bit input
            x[2] <= $signed(in[7:4]);    // Sign-extend the 4-bit input
            x[3] <= $signed(in[3:0]);    // Sign-extend the 4-bit input
        end
    end

    // Compute the 4-point DIF FFT
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < 4; i = i + 1) begin
                temp[i] <= 16'sb0; // Initialize intermediate results to signed 0
            end
            out <= 16'sb0;  // Initialize output to signed 0
        end else begin
            // Stage 1: Butterfly calculations
            temp[0] <= x[0] + x[2]; // Real part of first butterfly
            temp[1] <= x[1] + x[3]; // Real part of second butterfly
            temp[2] <= x[0] - x[2]; // Real part of third butterfly
            temp[3] <= x[1] - x[3]; // Real part of fourth butterfly

            // Stage 2: Twiddle factor multiplication for index 2 and 3
            // Since W0 = 1 and W1 = 1 for real-only inputs, no change is needed here
            temp[2] <= temp[2]; // W0 is 1, so no change
            temp[3] <= temp[3]; // W1 is 1 for real-only inputs

            // Pack the output results, sign-extend the 4-bit results to 16-bits
            out <= {temp[0][3:0], temp[1][3:0], temp[2][3:0], temp[3][3:0]};
        end
    end

endmodule
