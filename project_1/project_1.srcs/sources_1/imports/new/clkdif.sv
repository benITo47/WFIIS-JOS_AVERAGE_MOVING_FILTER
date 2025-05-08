`timescale 1ns / 1ps

module clkdiv (
    input logic clk,
    input logic resetn,
    output logic clk_out
);

    logic [7:0] counter;

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            counter <= 0;
            clk_out <= 0;
        end else begin
            if (counter == 8'd127) begin
                clk_out <= ~clk_out;
                counter <= 0;
            end else begin
                counter <= counter + 1;
            end
        end
    end

endmodule
