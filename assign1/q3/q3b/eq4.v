module eq4
  (
   input wire [3:0] a, b,
   output wire      aeqb
   );

   wire             e0, e1;

   eq2 eq_bit10_unit (.a(a[1:0]), .b(b[1:0]), .aeqb(e0));
   eq2 eq_bit32_unit (.a(a[3:2]), .b(b[3:2]), .aeqb(e1));

   assign aeqb = e0 & e1;

endmodule
