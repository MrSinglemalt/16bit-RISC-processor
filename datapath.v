module datapath(
    input clk,
    output wire [3:0] opcode,
    input wire reg_dst, alu_src, mem_to_reg, reg_w, mem_r, mem_w, beq, bne, j,
    input wire [1:0] alu_op
); //chipcontrol의 반대

wire [15:0] instruction; //im
reg [15:0] pc;           //im
wire [15:0] mem_read_data; //dm

wire [15:0] alu_out;       
wire [2:0] alu_cnt;
wire [15:0] pc_plus2;
assign pc_plus2 = pc+ 16'd2;

assign opcode = instruction[15:12];
wire [15:0] rd1,rd2,wd; //gpr   
wire [2:0] rs1, rs2, ws;
assign rs1 = instruction[11:9];
assign rs2 = instruction[8:6];
assign ws = reg_dst ? instruction[5:3] : instruction[8:6]; 
assign wd = mem_to_reg ? mem_read_data : alu_out;

wire [15:0] immext;
assign immext = {{10{instruction[5]}},instruction[5:0]}; //extend branch offset
wire [15:0] b;
assign b = alu_src? immext : rd2; //alu_src = 1이면 주소값을 가져가서 rd1과 더함(load,store 할 주소생성)

/// branch, jump를 위한 pc변경 
wire [15:0] pc_branch, pc_jump, pc_next;
assign pc_branch = pc_plus2 + {immext[14:0],1'b0};
assign pc_jump = {pc_plus2[15:13], instruction[11:0],1'b0}; //다음pc 앞3개가져오고, inst~~.v에서 right shift하며 받으니 미리 left shift해서 전달. 
wire iszero; //beq, bne 비교 결과값 (beq에서 조건맞으면 1, bne에서 조건맞으면 0)
assign pc_next = j? pc_jump : (((beq&iszero) | (bne&(~iszero))))? pc_branch : pc_plus2 ;

initial begin
  pc <= 16'b0;
end
always @ (posedge clk) begin
  pc <= pc_next;
end

instructionmemory im_connect(               //instructionmemory
    .pc(pc), .instruction(instruction)
);

datamemory dm_connect(                      //datamemory
    .clk(clk), .mem_address(alu_out), .mem_write_data(rd2),
    .mem_write_enable(mem_w), .mem_read_enable(mem_r),
    .mem_read_data(mem_read_data)
);

alu alu_connect(                            //alu
    .a(rd1), .b(b), .alu_cnt(alu_cnt), .result(alu_out), .iszero(iszero)
);

alucontrol alucontrol_connect(
    .alu_op(alu_op), .opcode(opcode), .alu_cnt(alu_cnt)
);

gpr gpr_connect(
    .clk(clk) ,.we(reg_w), .rs1(rs1), .rs2(rs2), .ws(ws), .rd1(rd1), .rd2(rd2), .wd(wd)
);

endmodule