module eq4wrapper
  (
   input wire [3:0] sw,
   input wire       pb1, pb2,
   output wire      ledpin
   );

   reg              a = 4'b0000;
   reg              b = 4'b0000;

   eq4 eq_unit (.a(a), .b(b), .aeqb(ledpin));

   always @(pb1)
     begin
        a <= sw;
     end

   always @(pb2)
     begin
        b <= sw;
     end

endmodule
