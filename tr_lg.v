module tr_lg(
    input clk, rst,
    output reg [2:0] light  // {Red, Yellow, Green}
);

    // State encoding
    parameter [1:0] RED = 2'b00,
                    GREEN = 2'b01,
                    YELLOW = 2'b10;

    reg [1:0] state, next_state;
    reg [3:0] count;  // counter for delay

    // State register and counter
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= RED;
            count <= 0;
        end
        else begin
            state <= next_state;
            // Reset counter when state changes
            if (state != next_state)
                count <= 0;
            else
                count <= count + 1;
        end
    end

    // Next-state logic
    always @(*) begin
        next_state = state;
        case (state)
            RED:    if (count == 4) next_state = GREEN;   // 4 cycles Red
            GREEN:  if (count == 6) next_state = YELLOW;  // 6 cycles Green
            YELLOW: if (count == 2) next_state = RED;     // 2 cycles Yellow
            default: next_state = RED;
        endcase
    end

    // Output logic - {Red, Yellow, Green}
    always @(*) begin
        case (state)
            RED:    light = 3'b100; // Red ON
            YELLOW: light = 3'b010; // Yellow ON
            GREEN:  light = 3'b001; // Green ON
            default: light = 3'b000;
        endcase
    end

endmodule