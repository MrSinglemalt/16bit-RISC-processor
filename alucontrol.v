module alucontrol(
    input wire [1:0] alu_op,
    input wire [3:0] opcode,
    output reg [2:0] alu_cnt
);
always @ ({alu_op,opcode}) begin
    casex ({alu_op,opcode}) 
    6'b10xxxx: alu_cnt = 3'b000; //Load, Store (+) : offset이랑 더해야
    6'b01xxxx: alu_cnt = 3'b001; //beq, bne (-) : 비교하기위해 빼기
    6'b000010: alu_cnt = 3'b000; // +
    6'b000011: alu_cnt = 3'b001; // -
    6'b000100: alu_cnt = 3'b010; // ~
    6'b000101: alu_cnt = 3'b011; // <<
    6'b000110: alu_cnt = 3'b100; // >>
    6'b000111: alu_cnt = 3'b101; // &
    6'b001000: alu_cnt = 3'b110; // |
    6'b001001: alu_cnt = 3'b111; // slt
    default: alu_cnt = 3'b000;
    endcase
end
endmodule