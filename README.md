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

# Code
```
module tr_lg(
    input clk, rst,
    output reg [2:0] light
);

    parameter [1:0] RED = 2'b00,
                    GREEN = 2'b01,
                    YELLOW = 2'b10;

    reg [1:0] state, next_state;
    reg [3:0] count;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= RED;
            count <= 0;
        end
        else begin
            state <= next_state;
            if (state != next_state)
                count <= 0;
            else
                count <= count + 1;
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            RED:    if (count == 4) next_state = GREEN;
            GREEN:  if (count == 6) next_state = YELLOW;
            YELLOW: if (count == 2) next_state = RED;
            default: next_state = RED;
        endcase
    end

    always @(*) begin
        case (state)
            RED:    light = 3'b100;
            YELLOW: light = 3'b010;
            GREEN:  light = 3'b001;
            default: light = 3'b000;
        endcase
    end

endmodule

```
# Test Bench
```
module tr_lg_tb;
    reg clk_t, rst_t;
    wire [2:0] light_t;

    tr_lg dut (
        .clk(clk_t),
        .rst(rst_t),
        .light(light_t)
    );

    always #20 clk_t = ~clk_t;

    initial begin
        clk_t = 1'b1;
        rst_t = 1'b1;
        #100;
        rst_t = 1'b0;
        #200;
    end
endmodule
```
# output
<img width="1919" height="1199" alt="Screenshot 2025-11-17 215659" src="https://github.com/user-attachments/assets/f3b081ab-c824-4caa-856f-1a25d77335b1" />


# Result
The Traffic Light Controller circuit was successfully designed and simulated using Verilog HDL in Vivado 2023.1 targeting the Spartan-7 FPGA. The simulation results show that the traffic lights switched sequentially — Red → Green → Yellow → Red — according to the specified time delays, demonstrating the correct functioning of the traffic control logic.



