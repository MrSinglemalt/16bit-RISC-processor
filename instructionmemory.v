module instructionmemory(
    input wire [15:0] pc,
    output wire [15:0] instruction
);

reg [15:0] memory [5:0];

assign instruction = memory[{1'b0,pc[15:1]}]; // address = pc/2

initial begin
    $readmemb("./memory/instructionmemory.txt",memory);
    $displayb(memory[1]);
    $displayb(instruction[1]);
end
endmodule