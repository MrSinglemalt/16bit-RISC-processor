module datamemory(
    input clk,
    input wire [15:0] mem_address, mem_write_data,
    input wire mem_write_enable, mem_read_enable,
    output [15:0] mem_read_data
);
reg [15:0] memory [7:0];

assign mem_read_data =(mem_read_enable)? memory[mem_address] : 1'b0; //for Load
initial begin
  $readmemb("./memory/datamemory.txt",memory);
end

always @ (posedge clk) begin
    if (mem_write_enable) begin
      memory[mem_address] <= mem_write_data;
    end
    // $displayb(memory[0]);
    // $displayb(memory[1]);
    // $displayb(memory[2]);
    // $displayb(memory[3]);
    // $display(mem_write_enable);
end
endmodule