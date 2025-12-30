module traffic_light(
    input clk,
    input reset,
    input emergency,
    output reg R1, Y1, G1,
    output reg R2, Y2, G2
);

reg [2:0] state;

parameter S1 = 3'b000,
          S2 = 3'b001,
          S3 = 3'b010,
          S4 = 3'b011;

always @(posedge clk or posedge reset)
begin
    if (reset)
        state <= S1;
    else if (emergency)
        state <= S4;
    else
        case(state)
            S1: state <= S2;
            S2: state <= S3;
            S3: state <= S1;
            S4: state <= S1;
        endcase
end

always @(*)
begin
    case(state)
        S1: begin
            G1 = 1; Y1 = 0; R1 = 0;
            R2 = 1; Y2 = 0; G2 = 0;
        end
        S2: begin
            G1 = 0; Y1 = 1; R1 = 0;
            R2 = 1; Y2 = 0; G2 = 0;
        end
        S3: begin
            G1 = 0; Y1 = 0; R1 = 1;
            R2 = 0; Y2 = 0; G2 = 1;
        end
        S4: begin
            G1 = 0; Y1 = 0; R1 = 1;
            G2 = 1; Y2 = 0; R2 = 0;
        end
    endcase
end

endmodule
