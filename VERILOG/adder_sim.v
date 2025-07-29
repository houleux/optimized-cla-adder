`include "adder.v"

module tb_adder;

reg [3:0] A;
reg [3:0] B;
reg clk;
wire [3:0] S;
wire Cout;

circuit u1(.A(A), .B(B), .clk(clk), .S(S), .Cout(Cout));

localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;

initial begin
  $dumpfile("tb_adder.vcd");
  $dumpvars(0, tb_adder);
end

initial begin
  $monitor("A = %b, B = %b, clk = %b, S = %b, Cout = %b, time = %t", A, B, clk, S, Cout, $time);

  clk = 0;
  A = 4'b1111;
  B = 4'b1001;

  #50 
  $finish;
end

endmodule
