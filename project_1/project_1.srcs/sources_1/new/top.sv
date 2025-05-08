`timescale 1ns / 1ps

module top (
    input logic clk,
    input logic resetn,
    input logic start,
    input logic spi_sync,
    output logic [7:0] led,
    output logic spi_sclk,
    output logic spi_mosi,
    input logic spi_miso
);

    logic clkdiv;

    clkdiv clk_div_inst (
        .clk(clk),
        .resetn(resetn),
        .clk_out(clkdiv)
    );

    spi_master spi_inst (
        .clk(clkdiv),
        .resetn(resetn),
        .data_in(data_in),
        .led(led),
        .spi_sclk(spi_sclk),
        .spi_mosi(spi_mosi),
        .spi_miso(spi_miso),
        .spi_sync(spi_sync)
    );

endmodule
