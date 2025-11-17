# Exp-6b-Traffic-Light-Controller
# Aim
To design and simulate a Verilog HDL for Traffic Light Controler

# Apparatus Required
Vivado 2023.1
Spartan 7 FPGA
# Procedure
1. Launch Vivado 2023.1
Open Vivado 2023.1 and create a new project.
Select RTL Project and enable Do not specify sources at this time.
2. Create Verilog Design File
Create a new Verilog design file.
Type the Verilog code for the Traffic Light Controler

3. Observe the Output
Observe the Traffic Signal output.

# code
```module tr_lg(
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
```
# Test Bench
```
module tr_lg_tb;
reg clk,rst;
    wire [2:0] light;

    tr_lg uut(clk,rst,light);

    initial clk=0; always #5 clk=~clk;

    initial begin
        rst=1; #10; rst=0;
        #200 $finish;   
    end

    initial begin
        $monitor("Time=%0t | Lights={Red,Yellow,Green}=%b", $time, light);
    end
endmodule
```
# output


# Result




