module pipeline_reg_1stage (
    input  logic        clk,
    input  logic        reset,      // active-high reset

    // Input side
    input  logic        in_valid,
    output logic        in_ready,
    input  logic [7:0]  in_data,

    // Output side
    output logic        out_valid,
    input  logic        out_ready,
    output logic [7:0]  out_data
);
    // Internal storage
    logic [7:0] buffer_data;
    logic       buffer_valid;

    // Combinational logic for handshake
    assign in_ready  = ~buffer_valid;   // ready when buffer is empty
    assign out_valid = buffer_valid;    // valid when buffer has data
    assign out_data  = buffer_data;     // output the stored data

    // Sequential logic: store and clear buffer (robust version)
    always_ff @(posedge clk) begin
        if (reset) begin
            buffer_valid <= 1'b0;   // empty on reset
        end else begin
            case ({in_valid && in_ready, out_valid && out_ready})
                2'b10: begin
                    // Only input handshake
                    buffer_data  <= in_data;
                    buffer_valid <= 1'b1;
                end
                2'b01: begin
                    // Only output handshake
                    buffer_valid <= 1'b0;
                end
                2'b11: begin
                    // Both input and output handshake in same cycle (pass-through)
                    buffer_data  <= in_data;  // replace old with new
                    buffer_valid <= 1'b1;     // remains full
                end
                default: begin
                    // No handshake: hold state
                    buffer_valid <= buffer_valid;
                end
            endcase
        end
    end
endmodule


