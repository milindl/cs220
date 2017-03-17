`timescale 1ns / 1ps

module eq2_testbench;
   reg [1:0] test_in0, test_in1;
   wire      test_out;

   eq2 uut
     (.a(test_in0), .b(test_in1), .aeqb(test_out));

   initial
     begin
        # 100;

        test_in0 = 2'b00;
        test_in1 = 2'b00;
        # 200;
        test_in0 = 2'b01;
        test_in1 = 2'b00;
        # 200;
        test_in0 = 2'b01;
        test_in1 = 2'b11;
        # 200;
        test_in0 = 2'b10;
        test_in1 = 2'b10;
        # 200;
        test_in0 = 2'b10;
        test_in1 = 2'b00;
        # 200;
        test_in0 = 2'b11;
        test_in1 = 2'b11;
        # 200;
        test_in0 = 2'b11;
        test_in1 = 2'b01;
        # 200;
        $stop;
     end // initial begin

endmodule // eq2_testbench
