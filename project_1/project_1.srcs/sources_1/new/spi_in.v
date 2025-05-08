module spi_in (
    input logic clk,               // Zegar
    input logic reset,             // Reset
    input logic start,             // Sygnał startowy do rozpoczęcia transmisji SPI
    input logic [11:0] adc_data,   // Odczytane dane z ADC (12-bit)
    output logic [7:0] leds        // Wyjście sterujące diodami LED
);

    // Wartość progowa dla 1.65V (ADC dla 1.65V to około 2047)
    localparam THRESHOLD = 2047;
    
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            leds <= 8'b0;   // W razie resetu wyłącz wszystkie diody
        end else if (adc_data >= THRESHOLD) begin
            leds <= 8'b00000001; // Zapal pierwszą diodę, jeśli ADC > 1.65V
        end else begin
            leds <= 8'b0;   // Jeśli ADC < 1.65V, wszystkie diody są wyłączone
        end
    end

endmodule