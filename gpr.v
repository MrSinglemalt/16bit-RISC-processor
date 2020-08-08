module gpr(
    input clk,
    input wire we, //write enable
    input wire [2:0] rs1, rs2,ws,wd, //read ,write 할 address
    output wire [15:0] rd1,rd2      //rs1, rs2 주소에 있는 data
);
reg [15:0] gprarray [7:0];
assign rd1 = gprarray[rs1];
assign rd2 = gprarray[rs2];

integer i;
initial begin
    for(i=0;i<8;i++)
        gprarray[i] <= 16'b0;
end

always @(posedge clk) begin
    if(we) begin
        gprarray[ws] <= wd;
    end
end

endmodule