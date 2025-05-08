`timescale 1ns / 1ps

module spi_master (
    input clk,
    input resetn,
    output reg [7:0] led,
    output reg spi_sclk,
    output reg spi_mosi,
    input spi_miso,
    input spi_sync
);

    reg [7:0] rx_data;
    reg [3:0] bit_count;

    typedef enum logic [1:0] {
        IDLE = 2'b00,
        TRANSFER = 2'b01,
        DONE = 2'b10
    } state_t;

    state_t state, next_state;

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    always @(state or bit_count) begin
        case(state)
            IDLE: next_state = TRANSFER;  
            TRANSFER: next_state = (bit_count == 4'b1000) ? DONE : TRANSFER;
            DONE: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            spi_sclk <= 0;
            spi_mosi <= 0;
            bit_count <= 0;
            led <= 0;
        end else begin
            case(state)
                IDLE: begin
                    bit_count <= 0;
                    led <= 0;
                end
                TRANSFER: begin
                    spi_sclk <= ~spi_sclk;
                    spi_mosi <= data_in[7 - bit_count];
                    rx_data[bit_count] <= spi_miso;
                    bit_count <= bit_count + 1;
                end
                DONE: begin
                    led <= rx_data;
                end
            endcase
        end
    end
endmodule
