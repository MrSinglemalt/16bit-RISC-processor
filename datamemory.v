module datamemory(
    input clk,
    input wire [15:0] mem_address, mem_write_data,
    input wire mem_write_enable, mem_read_enable,
    output [15:0] mem_read_data
);
reg [15:0] memory [7:0];
initial begin
  $readmemb("./memory/datamemory.txt",memory);
end

assign mem_read_data =(mem_write_enable)? memory[mem_address] : 1'b0; //for LW

always @ (posedge clk) begin
    if (mem_write_enable) begin
      memory[mem_address] <= mem_write_data;
    end
end
endmodule