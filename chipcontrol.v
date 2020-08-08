module chipcontrol(
    input wire [3:0] opcode,
    output reg reg_dst, alu_src, mem_to_reg, reg_w, mem_r, mem_w, beq, bne, j,
    output reg [1:0] alu_op
);

always @(*) begin
    case(opcode)
    4'd0: {reg_dst, alu_src, mem_to_reg, reg_w, mem_r, mem_w, beq, bne, alu_op[1:0], j}
    = 11'b01111000100;  //Load Word

    4'd1: {reg_dst, alu_src, mem_to_reg, reg_w, mem_r, mem_w, beq, bne, alu_op[1:0], j}
    = 11'b01000100100; //Store Word

    4'd2 | 4'd3 | 4'd4 | 4'd5 | 4'd6 | 4'd7 | 4'd8 | 4'd9 | 4'd10 | 4'd11:
    {reg_dst, alu_src, mem_to_reg, reg_w, mem_r, mem_w, beq, bne, alu_op[1:0], j}
    = 11'b10010000000; //cal

    4'd12: {reg_dst, alu_src, mem_to_reg, reg_w, mem_r, mem_w, beq, bne, alu_op[1:0], j}
    = 11'b00000010010; //beq

    4'd13: {reg_dst, alu_src, mem_to_reg, reg_w, mem_r, mem_w, beq, bne, alu_op[1:0], j}
    = 11'b00000001010; //bne

    default: {reg_dst, alu_src, mem_to_reg, reg_w, mem_r, mem_w, beq, bne, alu_op[1:0], j}
    = 11'b00000000001; //jump
    endcase
end
endmodule