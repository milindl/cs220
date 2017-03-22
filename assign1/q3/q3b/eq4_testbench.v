`timescale 1ns / 1ps

module eq4_testbench;
   reg [3:0] test_in0, test_in1;
   wire      test_out;

   eq4 uut
     (.a(test_in0), .b(test_in1), .aeqb(test_out));

   initial
     begin
        # 100;

        test_in0 = 4'b0000;
        test_in1 = 4'b0000;
        # 200;
        test_in0 = 4'b0101;
        test_in1 = 4'b0001;
        # 200;
        test_in0 = 4'b0101;
        test_in1 = 4'b1111;
        # 200;
        test_in0 = 4'b1010;
        test_in1 = 4'b1010;
        # 200;
        test_in0 = 4'b1010;
        test_in1 = 4'b0000;
        # 200;
        test_in0 = 4'b1111;
        test_in1 = 4'b1111;
        # 200;
        test_in0 = 4'b1111;
        test_in1 = 4'b0101;
        # 200;
        $stop;
     end // initial begin

endmodule // eq4_testbench
