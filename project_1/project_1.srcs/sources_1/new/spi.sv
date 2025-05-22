`timescale 1ns / 1ps

module spi_master (
    input clk,             
    inout clk_div,        
    input resetn,         
    output reg [7:0] led,
    input spi_miso,        
    input spi_sync
);

    reg [15:0] rx_data_full; 
    reg [3:0] bit_count;   
     
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        TRANSFER = 2'b01,   
        DONE = 2'b10        
    } state_t;

    state_t state, next_state;

    always @(posedge clk or posedge resetn) begin
        if (resetn)
            state <= IDLE;
        else
            state <= next_state;
    end

    always @(*) begin
        case(state)
            IDLE: next_state = spi_sync ? TRANSFER : IDLE; 
            TRANSFER: next_state = (bit_count == 4'd15) ? DONE : TRANSFER; 
            DONE: next_state = IDLE; 
            default: next_state = IDLE;
        endcase
    end



always @(posedge clk_div or posedge resetn) begin
    if (resetn) begin
        bit_count <= 0;
        led <= 0;
        rx_data_full <= 0;
    end else begin
        case(state)
            IDLE: begin
                bit_count <= 0;
                led <= 0;
                rx_data_full <= 0;
            end

            TRANSFER: begin
                rx_data_full[15 - bit_count] <= spi_miso; 
                bit_count <= bit_count + 1;
            end

            DONE: begin
                led <= rx_data_full[11:4];
            end
        endcase
    end
end


endmodule
