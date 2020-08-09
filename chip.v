`include "alu.v"
`include "alucontrol.v"
`include "chipcontrol.v"
`include "gpr.v"
`include "datamemory.v"
`include "instructionmemory.v"
`include "datapath.v"

module chip(
    input clk
);
wire [3:0] opcode;
wire reg_dst, alu_src, mem_to_reg, reg_w, mem_r, mem_w, beq, bne, j;
wire [1:0] alu_op;

chipcontrol chip_connect(
    .opcode(opcode),
    .reg_dst(reg_dst), .alu_src(alu_src), .mem_to_reg(mem_to_reg),
    .reg_w(reg_w), .mem_r(mem_r), .mem_w(mem_w), .beq(beq), .bne(bne), .j(j),
    .alu_op(alu_op)
);

datapath datapath_connect(
    .opcode(opcode), .clk(clk),
    .reg_dst(reg_dst), .alu_src(alu_src), .mem_to_reg(mem_to_reg), .reg_w(reg_w), .mem_r(mem_r), .mem_w(mem_w), .beq(beq), .bne(bne), .j(j),
    .alu_op(alu_op)
);
endmodule