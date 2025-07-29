`timescale 1ns / 1ps

module dff (
    input [3:0] D,
    input clk,
    output reg [3:0] Q
);

  always @(posedge clk) begin
    Q <= D;
  end

  initial begin
    Q = 4'b0;
  end

endmodule

module dff2 (
    input D,
    input clk,
    output reg Q
);

  always @(posedge clk) begin
    Q <= D;
  end

  initial begin
    Q = 1'b0;
  end

endmodule

module C_L_adder (
    input [3:0] A,
    B,
    output [3:0] S,
    output wire Cout
);

  wire [3:0] P;
  wire [3:0] G1;
  wire [2:0] C;
  wire [2:0] h;


  assign P[0]  = A[0] ^ B[0];
  assign P[1]  = A[1] ^ B[1];
  assign P[2]  = A[2] ^ B[2];
  assign P[3]  = A[3] ^ B[3];

  assign G1[0] = ~(A[0] & B[0]);
  assign G1[1] = ~(A[1] & B[1]);
  assign G1[2] = ~(A[2] & B[2]);
  assign G1[3] = ~(A[3] & B[3]);


  assign C[0]  = ~(G1[0]);
  assign C[1]  = ~(G1[1] & ~(P[1] & ~(G1[0])) & ~(P[1] & P[0]));
  assign C[2]  = ~(G1[2] & ~(P[2] & ~(G1[1])) & ~(P[2] & P[1] & ~(G1[0])));
  assign h[0]  = ~(G1[3] & ~(G1[2]));
  assign h[1]  = ~(G1[3] & P[2] & ~(G1[1]));
  assign h[2]  = ~(G1[3] & P[2] & P[1] & ~G1[0]);

  assign Cout  = ~(G1[3] & h[0] & h[1] & h[2]);


  assign S[0]  = P[0];
  assign S[1]  = P[1] ^ C[0];
  assign S[2]  = P[2] ^ C[1];
  assign S[3]  = P[3] ^ C[2];

endmodule

module circuit (
    input [3:0] A,
    input [3:0] B,
    input clk,
    output [3:0] S,
    output wire Cout
);

  wire [3:0] Ad;
  wire [3:0] Bd;
  wire [3:0] SS;
  wire CC;

  dff u1 (
      .D  (A),
      .clk(clk),
      .Q  (Ad)
  );
  dff u2 (
      .D  (B),
      .clk(clk),
      .Q  (Bd)
  );

  C_L_adder u3 (
      .A(Ad),
      .B(Bd),
      .S(SS),
      .Cout(CC)
  );

  dff u4 (
      .D  (SS),
      .clk(clk),
      .Q  (S)
  );
  dff2 u5 (
      .D  (CC),
      .clk(clk),
      .Q  (Cout)
  );

endmodule

