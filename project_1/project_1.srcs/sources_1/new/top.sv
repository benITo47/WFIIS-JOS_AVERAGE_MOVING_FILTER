`timescale 1ns / 1ps

module top (
    input clk,
    input resetn,
    output spi_sync,
    output [7:0] led,
    output spi_sclk,
    input spi_miso,
    output spi_sclk_2, spi_miso_2, spi_sync_2
    //D0
);
assign {spi_sclk_2, spi_miso_2, spi_sync_2} = {spi_sclk, spi_miso, spi_sync};
    clkdiv #(.DIVIDER(50), .OFFSET(3)) clk_div_inst1 (
        .clk(clk),
        .resetn(resetn),
        .clk_out(spi_sclk)
    );
   
     clkdiv #(.DIVIDER(10_000)) clk_div_inst2 (
        .clk(clk),
        .resetn(resetn),
        .clk_out(spi_sync)
    );

    spi_master spi_inst (
        .clk(clk),
        .clk_div(spi_sclk),
        .resetn(resetn),
        .led(led),
        .spi_miso(spi_miso),
        .spi_sync(spi_sync)
    );

endmodule
