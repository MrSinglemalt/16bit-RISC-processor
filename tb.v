module tb;
reg clk;

initial begin
clk <= 0;
$dumpfile("16bitRISC.vcd");
$dumpvars;
#30 $finish;
end
always begin
#1 clk=~clk;
end

chip DUT(
    .clk(clk)
);
endmodule