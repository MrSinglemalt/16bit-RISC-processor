module alu(
    input wire [15:0] a,b,
    input wire [2:0] alu_cnt,
    output reg [15:0] result,
    output wire iszero
);

always @(*) begin
    case(alu_cnt)
    3'h0: result = a+b;
    3'h1: result = a-b;
    3'h2: result = ~a;
    3'h3: result = a<<b;
    3'h4: result = a>>b;
    3'h5: result = a & b;
    3'h6: result = a | b;
    3'h7: //SLT (set less than)
        begin
            if (a<b)
                result = 16'b1;
            else
                result = 16'b0;
        end
    default: result = a+b;
    endcase
end

assign iszero = (result==16'd0) ? 1'b1 : 1'b0; //beq, bne에서 사용
endmodule