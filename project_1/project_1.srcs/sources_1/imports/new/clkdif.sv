`timescale 1ns / 1ps

module clkdiv #(
    parameter integer DIVIDER = 256,
    parameter integer OFFSET = 0
)(
    input logic clk,
    input logic resetn,
    output logic clk_out
);

    logic [$clog2(DIVIDER)-1 + OFFSET:0] counter;

    always @(posedge clk or posedge resetn) begin
        if (resetn) begin
            counter <= 0;
            clk_out <= 0;
        end else begin
            if (counter == (DIVIDER/2 - 1 + OFFSET)) begin
                clk_out <= ~clk_out;
                counter <= 0;
            end else begin
                counter <= counter + 1;
            end
        end
    end

endmodule
