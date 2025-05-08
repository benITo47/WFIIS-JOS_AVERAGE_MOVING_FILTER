`timescale 1ns / 1ps

module tb_spi_master;

    logic clk;
    logic resetn;
    logic [7:0] data_in;
    logic spi_sync;

    logic [7:0] led;
    logic spi_sclk;
    logic spi_mosi;
    logic spi_miso;

    spi_master uut (
        .clk(clk),
        .resetn(resetn),
        .led(led),
        .spi_sclk(spi_sclk),
        .spi_mosi(spi_mosi),
        .spi_miso(spi_miso),
        .spi_sync(spi_sync)
    );

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        resetn = 0;
        data_in = 8'b10101010;
        spi_sync = 0;

        #10 resetn = 1;
        #10 resetn = 0; 

        #20 data_in = 8'b11111111; 
        #40 data_in = 8'b00000000;  

        #500 $finish; 
    end

    initial begin
        $monitor("Time=%0t, clk=%b, resetn=%b, data_in=%b, led=%b, spi_sclk=%b, spi_mosi=%b, spi_miso=%b", 
                  $time, clk, resetn, data_in, led, spi_sclk, spi_mosi, spi_miso);
    end

endmodule
