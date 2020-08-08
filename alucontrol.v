module alucontrol(
    input wire [1:0] alu_op,
    input wire [3:0] opcode,
    output reg alu_cnt
);
always @ ({alu_op,opcode}) begin
    casex ({alu_op,opcode}) 
    6'b10xxxx: alu_cnt = 3'b000; 
    6'b01xxxx: alu_cnt = 3'b001; 
    6'h2: alu_cnt = 3'b000; 
    6'h3: alu_cnt = 3'b001; 
    6'h4: alu_cnt = 3'b010; 
    6'h5: alu_cnt = 3'b011;
    6'h6: alu_cnt = 3'b100; 
    6'h7: alu_cnt = 3'b101;
    6'h8: alu_cnt = 3'b110; 
    6'h9: alu_cnt = 3'b111; 
    default: alu_cnt = 3'b000;
    endcase
end
endmodule